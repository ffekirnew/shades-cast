from django.contrib.auth import get_user_model
from rest_framework import generics, permissions, viewsets, views

from .models import Podcast, Episode
from .serializers import PodcastSerializer, UserSerializer, EpisodeSerializer
from .permissions import IsCreatorOrReadOnly


class PodcastViewSet(viewsets.ModelViewSet):
    permission_classes = (IsCreatorOrReadOnly,)
    queryset = Podcast.objects.all()
    serializer_class = PodcastSerializer

# class PodcastListView(generics.ListCreateAPIView):
#     queryset = Podcast.objects.all()
#     serializer_class = PodcastSerializer


# class PodcastDetailView(generics.RetrieveUpdateDestroyAPIView):
#     permission_classes = (IsCreatorOrReadOnly, )
#     queryset = Podcast.objects.all()
#     serializer_class = PodcastSerializer


class UserViewSet(viewsets.ModelViewSet):
    queryset = get_user_model().objects.all()
    serializer_class = UserSerializer


# class UserListView(generics.ListCreateAPIView):
#     queryset = get_user_model().objects.all()
#     serializer_class = UserSerializer


# class UserDetailView(generics.RetrieveUpdateDestroyAPIView):
#     queryset = get_user_model().objects.all()
#     serializer_class = UserSerializer

class EpisodeViewSet(viewsets.ModelViewSet):
    queryset = Episode.objects.all()
    serializer_class = EpisodeSerializer