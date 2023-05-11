from django.shortcuts import get_object_or_404
from rest_framework import viewsets, generics
from rest_framework.exceptions import NotFound
from rest_framework.response import Response
from rest_framework.decorators import api_view

from taggit.models import Tag

from .models import Podcast, Episode
from podcasts.serializers import PodcastSerializer, EpisodeSerializer
from podcasts.permissions import IsEpisodeCreatorOrReadOnly, IsPodcastCreatorOrReadOnly


class PodcastViewSet(viewsets.ModelViewSet):
    permission_classes = (IsPodcastCreatorOrReadOnly,)
    queryset = Podcast.objects.all()
    serializer_class = PodcastSerializer

    def perform_create(self, serializer):
        serializer.validated_data['creator'] = self.request.user
        serializer.validated_data['categories'] = serializer.validated_data['categories'][0].split(
            ", ")
        serializer.save()


@api_view(['GET'])
def podcast_list_by_categories(request, tag_slug):
    if tag_slug:
        tag = get_object_or_404(Tag, slug=tag_slug)
        podcasts = Podcast.objects.filter(categories__in=[tag])
        serializer = PodcastSerializer(podcasts, many=True)
        return Response(serializer.data)


class EpisodeViewSet(viewsets.ModelViewSet):
    permission_classes = (IsEpisodeCreatorOrReadOnly,)
    queryset = Episode.objects.all()
    serializer_class = EpisodeSerializer


class PodcastEpisodesListView(generics.ListCreateAPIView):
    permission_classes = (IsPodcastCreatorOrReadOnly,)
    serializer_class = EpisodeSerializer

    def get_queryset(self):
        podcast_id = self.kwargs['podcast_id']
        try:
            podcast = Podcast.objects.get(id=podcast_id)
        except Podcast.DoesNotExist:
            raise NotFound('Podcast does not exist.')

        return podcast.episodes.all()

    def get(self, request, podcast_id, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.serializer_class(queryset, many=True)
        return Response(serializer.data)
