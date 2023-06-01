import random

from django.shortcuts import get_object_or_404
from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView
from rest_framework.permissions import IsAuthenticatedOrReadOnly
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response

from .models import Fact
from .serializers import FactSerializer
from .permissions import IsUserAdminOrReadOnly


@api_view(['GET'])
@permission_classes([IsAuthenticatedOrReadOnly])
def get_random_fact(request):
    count = Fact.objects.count()
    random_id = random.randint(1, count)

    random_fact = Fact.objects.get(id=random_id)
    serializer = FactSerializer(random_fact)

    return Response(serializer.data)


class FactsListView(ListCreateAPIView):
    permission_classes = [IsAuthenticatedOrReadOnly, ]
    queryset = Fact.objects.all()
    serializer_class = FactSerializer


class FactRetrieveUpdateView(RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticatedOrReadOnly, IsUserAdminOrReadOnly, ]
    queryset = Fact.objects.all()
    serializer_class = FactSerializer
