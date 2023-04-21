from rest_framework import serializers

from .models import Podcast, Episode


class EpisodeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Episode
        fields = ['id', 'title', 'slug', 'audio_file', 'audio_duration', 'audio_size', 'podcast', 'publish', 'description', 'status']



class PodcastSerializer(serializers.ModelSerializer):
    episodes = EpisodeSerializer(many=True, read_only=True)
    class Meta:
        model = Podcast
        fields = ['id', 'creator',  'title', 'slug', 'description', 'cover_image', 'category', 'publish', 'status', 'episodes']