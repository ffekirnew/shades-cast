from rest_framework import viewsets

from .models import Fact
from .serializers import FactSerializer
from .permissions import IsUserAdminOrReadOnly


class FactViewSet(viewsets.ModelViewSet):
    permission_classes = (IsUserAdminOrReadOnly,)
    queryset = Fact.objects.all()
    serializer_class = FactSerializer
