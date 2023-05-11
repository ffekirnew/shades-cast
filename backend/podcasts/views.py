from rest_framework import viewsets, generics
from rest_framework.exceptions import NotFound
from rest_framework.response import Response

from .models import Podcast, Episode
from podcasts.serializers import PodcastSerializer, EpisodeSerializer
from podcasts.permissions import IsCreatorOrReadOnly


class PodcastViewSet(viewsets.ModelViewSet):
    permission_classes = (IsCreatorOrReadOnly,)
    queryset = Podcast.objects.all()
    serializer_class = PodcastSerializer


class PodcastEpisodesListView(generics.ListCreateAPIView):
    permission_classes = (IsCreatorOrReadOnly,)
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


class EpisodeViewSet(viewsets.ModelViewSet):
    queryset = Episode.objects.all()
    serializer_class = EpisodeSerializer
