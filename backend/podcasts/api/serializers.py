from rest_framework import serializers
from ..models import Podcast, Episode

class PodcastSerializer(serializers.Serializer):
    class Meta:
        model = Podcast
        fields = ['id', 'title', 'slug', 'description'] #, 'cover_image', 'category', 'status']


class EpisodeSerializer(serializers.Serializer):
    class Meta:
        model = Episode
        fields = ['id', 'title', 'podcast', 'publish', 'description'] #, 'cover_image', 'category', 'status']
