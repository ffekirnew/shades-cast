from django.shortcuts import render
from rest_framework import viewsets

from .models import Fact
from .serializers import FactSerializer


class FactViewSet(viewsets.ModelViewSet):
    queryset = Fact.objects.all()
    serializer_class = FactSerializer

# Create your views here.
