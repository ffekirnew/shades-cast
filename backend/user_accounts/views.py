# Django Imports
from django.shortcuts import get_object_or_404
from django.contrib.auth import get_user_model

# Rest Framework Imports
from rest_framework import generics, viewsets, views, status
from rest_framework.permissions import IsAuthenticated
from rest_framework.exceptions import NotFound
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes

# Local app imports
from .models import Contact
from .serializers import UserSerializer, ProfileSerializer, ContactSerializer
from .permissions import IsOwnerOrReadOnly

# Neighbor app imports
from podcasts.serializers import PodcastSerializer
from podcasts.models import Podcast


class UserViewSet(viewsets.ModelViewSet):
    permission_classes = (IsAuthenticated, IsOwnerOrReadOnly,)
    queryset = get_user_model().objects.all()
    serializer_class = UserSerializer


class UserProfileDetailView(views.APIView):
    permission_classes = (IsAuthenticated, IsOwnerOrReadOnly,)

    def get(self, request, id, format=None):
        user = get_object_or_404(get_user_model(), id=id)
        profile = user.profile

        serializer = ProfileSerializer(profile)
        return Response(serializer.data)

    def put(self, request, id, format=None):
        user = get_object_or_404(get_user_model(), id=id)
        profile = user.profile

        serializer = ProfileSerializer(profile, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['GET'])
@permission_classes([IsAuthenticated, ])
def users_list(request):
    users = get_user_model().objects.all()
    serializer = UserSerializer(users, many=True)

    return Response(serializer.data)


class UserFollowersAPIView(generics.ListAPIView):
    serializer_class = UserSerializer

    def get_queryset(self):
        id = self.kwargs['id']
        try:
            user = get_user_model().objects.get(id=id)
        except get_user_model().DoesNotExist:
            raise NotFound("User does not exist.")
        return user.followers.all()

    def get(self, request, id, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.serializer_class(queryset, many=True)
        return Response(serializer.data)


@api_view(['POST', 'DELETE'])
@permission_classes([IsAuthenticated, ])
def user_add_follow_view(request, id):
    user_from = request.user
    user_to = user_from.following.filter(id=id)

    if not user_to:
        user_to = get_object_or_404(get_user_model(), id=id)
        Contact.objects.get_or_create(
            user_from=request.user,
            user_to=user_to)
        # new_follow = Contact.objects.create(user_from, user_to)
        # new_follow.save()

    return Response({'status': 'ok'})


class UserFollowingAPIView(generics.ListAPIView):
    serializer_class = UserSerializer

    def get_queryset(self):
        id = self.kwargs['id']
        try:
            user = get_user_model().objects.get(id=id)
        except get_user_model().DoesNotExist:
            raise NotFound("User does not exist.")
        return user.following.all()

    def get(self, request, id, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.serializer_class(queryset, many=True)
        return Response(serializer.data)


class UserPodcastsAPIView(generics.ListAPIView):
    serializer_class = PodcastSerializer

    def get_queryset(self):
        id = self.kwargs['id']
        try:
            user = get_user_model().objects.get(id=id)
        except get_user_model().DoesNotExist:
            raise NotFound("User does not exist.")
        return user.podcasts_created.all()

    def get(self, request, id, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.serializer_class(queryset, many=True)
        return Response(serializer.data)


class UserFavoritePodcastsAPIView(generics.ListAPIView):
    serializer_class = PodcastSerializer

    def get_queryset(self):
        id = self.kwargs['id']
        try:
            user = get_user_model().objects.get(id=id)
        except get_user_model().DoesNotExist:
            raise NotFound("User does not exist.")
        return user.favorites.all()

    def get(self, request, id, *args, **kwargs):
        queryset = self.get_queryset()
        serializer = self.serializer_class(queryset, many=True)
        return Response(serializer.data)
