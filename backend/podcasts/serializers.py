from django.contrib.auth import get_user_model
from rest_framework import serializers

from podcasts.models import Podcast, Episode


class EpisodeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Episode
        fields = ['id', 'title', 'slug', 'audio_file', 'audio_duration',
                  'audio_size', 'podcast', 'publish', 'description', 'status']


class PodcastSerializer(serializers.ModelSerializer):
    class Meta:
        model = Podcast
        fields = ['id', 'creator', 'title', 'slug', 'description',
                  'cover_image', 'category', 'publish', 'status']
