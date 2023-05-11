from django.contrib.auth import get_user_model
from rest_framework import serializers

from podcasts.models import Podcast, Episode
from taggit.serializers import TaggitSerializer, TagListSerializerField
from .models import Podcast

class PodcastSerializer(TaggitSerializer, serializers.ModelSerializer):
    categories = TagListSerializerField()
    creator = serializers.StringRelatedField()

    class Meta:
        model = Podcast
        fields = ['id', 'creator', 'title', 'description',
                  'cover_image', 'categories', 'publish', 'status']


class EpisodeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Episode
        fields = ['id', 'title', 'audio_file', 'audio_duration',
                  'audio_size', 'podcast', 'tags_list', 'publish', 'description', 'status']


