from rest_framework import serializers
from ..models import Podcast, Episode


class PodcastSerializer(serializers.Serializer):
    class Meta:
        model = Podcast
        # , 'cover_image', 'category', 'status']
        fields = ['id', 'title', 'slug', 'description']


class EpisodeSerializer(serializers.Serializer):
    class Meta:
        model = Episode
        # , 'cover_image', 'category', 'status']
        fields = ['id', 'title', 'podcast', 'publish', 'description']
