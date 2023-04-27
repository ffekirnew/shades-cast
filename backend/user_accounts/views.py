from rest_framework import viewsets
from django.contrib.auth import get_user_model

from .serializers import UserSerializer, ContactSerializer
from .permissions import IsOwnerOrReadOnly, IsFollowerOrReadOnly
from .models import Contact


class UserViewSet(viewsets.ModelViewSet):
    permission_classes = (IsOwnerOrReadOnly,)
    queryset = get_user_model().objects.all()
    serializer_class = UserSerializer


class ContactViewSet(viewsets.ModelViewSet):
    permission_classes = (IsFollowerOrReadOnly,)
    queryset = Contact.objects.all()
    serializer_class = ContactSerializer
