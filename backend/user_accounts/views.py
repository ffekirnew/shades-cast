from rest_framework import generics
from rest_framework.permissions import IsAuthenticated

from rest_framework.exceptions import NotFound
from rest_framework.response import Response

from django.contrib.auth import get_user_model

from .serializers import UserSerializer, ContactSerializer
from .permissions import IsOwnerOrReadOnly, IsFollowerOrReadOnly
from .models import Contact

from podcasts.serializers import PodcastSerializer


class UserListView(generics.ListCreateAPIView):
    permission_classes = (IsAuthenticated,)
    queryset = get_user_model().objects.all()
    serializer_class = UserSerializer


class UserDetailView(generics.RetrieveUpdateAPIView):
    permission_classes = (IsAuthenticated, IsOwnerOrReadOnly,)
    serializer_class = UserSerializer

    def get_queryset(self):
        username = self.kwargs['username']
        try:
            user = get_user_model().objects.get(username=username)
        except get_user_model().DoesNotExist:
            raise NotFound("User does not exist.")
        return user

    def get(self, request, username, *args, **kwargs):
        try:
            queryset = self.get_queryset()
        except NotFound as e:
            return Response({'detail': str(e)}, status=404)

        serializer = self.serializer_class(queryset)
        return Response(serializer.data)


class UserFollowersAPIView(generics.ListAPIView):
    serializer_class = UserSerializer

    def get_queryset(self):
        username = self.kwargs['username']
        try:
            user = get_user_model().objects.get(username=username)
        except get_user_model().DoesNotExist:
            raise NotFound("User does not exist.")
        return user.followers.all()

    def get(self, request, username, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.serializer_class(queryset, many=True)
        return Response(serializer.data)


class UserFollowingAPIView(generics.ListAPIView):
    serializer_class = UserSerializer

    def get_queryset(self):
        username = self.kwargs['username']
        try:
            user = get_user_model().objects.get(username=username)
        except get_user_model().DoesNotExist:
            raise NotFound("User does not exist.")
        return user.following.all()

    def get(self, request, username, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.serializer_class(queryset, many=True)
        return Response(serializer.data)


class UserPodcastsAPIView(generics.ListAPIView):
    serializer_class = PodcastSerializer

    def get_queryset(self):
        username = self.kwargs['username']
        try:
            user = get_user_model().objects.get(username=username)
        except get_user_model().DoesNotExist:
            raise NotFound("User does not exist.")
        return user.podcasts_created.all()

    def get(self, request, username, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.serializer_class(queryset, many=True)
        return Response(serializer.data)
