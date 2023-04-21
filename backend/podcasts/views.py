from rest_framework import generics, permissions

from .models import Podcast
from .serializers import PodcastSerializer
from .permissions import IsCreaterOrReadOnly


class PodcastListView(generics.ListCreateAPIView):
    queryset = Podcast.objects.all()
    serializer_class = PodcastSerializer


class PodcastDetailView(generics.RetrieveUpdateDestroyAPIView):
    permission_classes = (IsCreaterOrReadOnly, )
    queryset = Podcast.objects.all()
    serializer_class = PodcastSerializer