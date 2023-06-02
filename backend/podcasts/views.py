from django.shortcuts import get_object_or_404

from django.contrib.postgres.search import SearchVector, SearchQuery, SearchRank, TrigramSimilarity

from rest_framework import viewsets, generics
from rest_framework.exceptions import NotFound
from rest_framework.response import Response
from rest_framework.decorators import api_view

from taggit.serializers import TaggitSerializer

from .models import Podcast, Episode
from podcasts.serializers import PodcastSerializer, EpisodeSerializer
from podcasts.permissions import IsEpisodeCreatorOrReadOnly, IsPodcastCreatorOrReadOnly

from user_accounts.serializers import UserSerializer

from taggit.models import Tag


# Podcast and related views


class PodcastViewSet(viewsets.ModelViewSet):
    permission_classes = (IsPodcastCreatorOrReadOnly,)
    queryset = Podcast.objects.all()
    serializer_class = PodcastSerializer

    def perform_create(self, serializer):
        serializer.validated_data['creator'] = self.request.user
        serializer.validated_data['categories'] = serializer.validated_data['categories'][0].split(
            ", ")
        serializer.save()


class PodcastEpisodesListView(generics.ListCreateAPIView):
    permission_classes = (IsPodcastCreatorOrReadOnly,)
    serializer_class = EpisodeSerializer

    def get_queryset(self):
        id = self.kwargs['id']
        try:
            podcast = Podcast.objects.get(id=id)
        except Podcast.DoesNotExist:
            raise NotFound('Podcast does not exist.')

        return podcast.episodes.all()

    def get(self, request, id, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.serializer_class(queryset, many=True)
        return Response(serializer.data)


class EpisodeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsEpisodeCreatorOrReadOnly,)
    queryset = Episode.objects.all()
    serializer_class = EpisodeSerializer

    def perform_create(self, serializer):
        serializer.validated_data['tags'] = serializer.validated_data['tags'][0].split(
            ", ")
        serializer.save()


@api_view(['GET'])
def podcast_list_by_categories(request, category_slug):
    if category_slug:
        tag = get_object_or_404(Tag, slug=category_slug)
        podcasts = Podcast.objects.filter(categories__in=[tag])
        serializer = PodcastSerializer(podcasts, many=True)
        return Response(serializer.data)


@api_view(['POST'])
def podcast_add_favorite(request, id):
    podcast = get_object_or_404(Podcast, id=id)
    podcast.favorited_by.add(request.user)

    return Response({'status': 'ok'})


@api_view(['DELETE'])
def podcast_delete_favorite(request, id):
    podcast = get_object_or_404(Podcast, id=id)

    if request.user in podcast.favorited_by.all():
        podcast.favorited_by.remove(request.user)
        return Response({'status': 'ok'})
    else:
        return Response({'status': 'error', 'message': 'User has not favorited this podcast.'}, status=400)


@api_view(['GET'])
def podcast_favorited_by(request, id):
    podcast = get_object_or_404(Podcast, id=id)
    favorited_by = podcast.favorited_by
    serializer = UserSerializer(favorited_by, many=True)

    return Response(serializer.data)


@api_view(['GET'])
def episode_list_by_tags(request, tag_slug):
    if tag_slug:
        tag = get_object_or_404(Tag, slug=tag_slug)
        episodes = Episode.objects.filter(tags__in=[tag])
        serializer = EpisodeSerializer(episodes, many=True)
        return Response(serializer.data)
