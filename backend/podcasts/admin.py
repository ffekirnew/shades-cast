from django.contrib import admin
from .models import Podcast, Episode, Subscription, Playback


@admin.register(Podcast)
class PodcastAdmin(admin.ModelAdmin):
    list_display = ('title', 'creator', 'categories')
    prepopulated_fields = {'slug': ('title',)}


@admin.register(Episode)
class EpisodeAdmin(admin.ModelAdmin):
    list_display = ('title', 'podcast', 'tags', 'audio_duration', 'audio_size', 'publish')
    list_filter = ('status', 'created', 'publish', 'podcast')
    # search_fields = ('title', 'body')
    prepopulated_fields = {'slug': ('title',)}
    # raw_id_fields = ('podcast',)
    # date_hierarchy = 'publish'
    # ordering = ('status', 'publish')
