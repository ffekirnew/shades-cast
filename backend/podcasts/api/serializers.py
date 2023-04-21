from rest_framework import serializers
from ..models import Podcast, Episode


class PodcastSerializer(serializers.ModelSerializer):
    class Meta:
        model = Podcast
        # , 'cover_image', 'category', 'status']
        fields = ['id', 'title', 'slug', 'description', 'cover_image', 'category', 'publish', 'status']


class EpisodeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Episode
        # , 'cover_image', 'category', 'status']
        fields = ['id', 'title', 'slug', 'audio_file', 'audio_duration', 'audio_size', 'podcast', 'publish', 'description', 'status']
