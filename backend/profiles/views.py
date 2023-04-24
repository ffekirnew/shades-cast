from rest_framework import viewsets

from .models import Profile
from .serializers import ProfileSerializer
from .permissions import IsProfileOwner


class ProfileViewSet(viewsets.ModelViewSet):
    permission_classes = (IsProfileOwner,)
    queryset = Profile.objects.all()
    serializer_class = ProfileSerializer
