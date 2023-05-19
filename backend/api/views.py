from django.contrib.postgres.search import TrigramSimilarity

from rest_framework import serializers
from rest_framework.decorators import api_view
from rest_framework.response import Response

from taggit.models import Tag
from podcasts.models import Episode, Podcast
from podcasts.serializers import EpisodeSerializer, PodcastSerializer


@api_view(['GET'])
def search(request, query):
    podcast_results = Podcast.objects.annotate(
        similarity=TrigramSimilarity('title', query) + TrigramSimilarity('description', query),
    ).filter(similarity__gt=0.1).order_by('-similarity')

    episode_results = Episode.objects.annotate(
        similarity=TrigramSimilarity('title', query) + TrigramSimilarity('description', query),
    ).filter(similarity__gt=0.1).order_by('-similarity')

    tag_results = Tag.objects.annotate(
        similarity=TrigramSimilarity('name', query),
    ).filter(similarity__gt=0.1).order_by('-similarity')

    podcasts_serialized = PodcastSerializer(podcast_results, many=True)
    episodes_serialized = EpisodeSerializer(episode_results, many=True)
    tags_serialized = TagSerializer(tag_results, many=True)

    results = {
        'podcasts': podcasts_serialized.data,
        'episodes': episodes_serialized.data,
        'tags': tags_serialized.data
    }

    return Response(results)


class TagSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tag
        fields = ['id', 'name']
