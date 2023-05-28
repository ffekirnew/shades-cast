from django.contrib.postgres.search import TrigramSimilarity
from django.shortcuts import get_object_or_404
from django.contrib.auth import get_user_model

from rest_framework import viewsets
from rest_framework.decorators import api_view, permission_classes
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework import status

from taggit.models import Tag
from podcasts.models import Episode, Podcast
from podcasts.serializers import EpisodeSerializer, PodcastSerializer
from user_accounts.serializers import UserSerializer, ProfileSerializer

from .serializers import TagSerializer


@api_view(['GET'])
def search(request, query):
    podcast_results = Podcast.objects.annotate(
        similarity=TrigramSimilarity(
            'title', query) + TrigramSimilarity('description', query)
    ).filter(similarity__gt=0.01).order_by('-similarity')

    episode_results = Episode.objects.annotate(
        similarity=TrigramSimilarity(
            'title', query) + TrigramSimilarity('description', query)
    ).filter(similarity__gt=0.01).order_by('-similarity')

    tag_results = Tag.objects.annotate(
        similarity=TrigramSimilarity('name', query)
    ).filter(similarity__gt=0.01).order_by('-similarity')

    podcasts_serialized = PodcastSerializer(podcast_results, many=True)
    episodes_serialized = EpisodeSerializer(episode_results, many=True)
    tags_serialized = TagSerializer(tag_results, many=True)

    results = {
        'podcasts': podcasts_serialized.data,
        'episodes': episodes_serialized.data,
        'tags': tags_serialized.data
    }

    return Response(results)


class UserDetailAPIView(APIView):
    permission_classes = (IsAuthenticated,)
    serializer_class = UserSerializer

    def get(self, request, format=None):
        user = get_object_or_404(get_user_model(), id=request.user.id)
        serializer = UserSerializer(user)
        return Response(serializer.data)

    def put(self, request, format=None):
        user = get_object_or_404(get_user_model(), id=request.user.id)
        serializer = self.serializer_class(user, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def patch(self, request, format=None):
        user = get_object_or_404(get_user_model(), id=request.user.id)
        serializer = self.serializer_class(
            user, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class UserProfileAPIView(APIView):
    permission_classes = (IsAuthenticated,)
    serializer_class = ProfileSerializer

    def get(self, request, format=None):
        print('here')
        user = get_object_or_404(get_user_model(), id=request.user.id)
        profile = user.profile
        serializer = ProfileSerializer(profile)
        return Response(serializer.data)

    def put(self, request, format=None):
        print('here put')
        user = get_object_or_404(get_user_model(), id=request.user.id)
        profile = user.profile
        serializer = self.serializer_class(profile, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def patch(self, request, format=None):
        print('here patch')
        user = get_object_or_404(get_user_model(), id=request.user.id)
        profile = user.profile
        serializer = self.serializer_class(profile, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class UserPodcastsViewset(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated,)
    serializer_class = PodcastSerializer

    def get_queryset(self):
        return Podcast.objects.filter(creator__id=self.request.user.id)


@api_view(['GET'])
def user_favorite_podcasts_list(request):
    podcasts = Podcast.objects.filter(favorited_by__in=[request.user.id])
    serializer = PodcastSerializer(podcasts, many=True)
    print(podcasts)

    return Response(serializer.data)
