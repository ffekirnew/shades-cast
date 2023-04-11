from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone

from .models_utils import get_audio_duration_and_size, get_audio_upload_path, get_image_upload_path


class Podcast(models.Model):
    STATUS_CHOICES = [
        ('private', 'Private'),
        ('public', 'Public')
    ]

    title = models.CharField(max_length=255)
    slug = models.SlugField(max_length=250, unique='publish')
    description = models.TextField(blank=True)

    cover_image = models.ImageField(upload_to=get_image_upload_path, blank=True)

    category = models.CharField(max_length=255, blank=True)

    publish = models.DateTimeField(default=timezone.now)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    status = models.CharField(max_length=7,
                              choices=STATUS_CHOICES,
                              default='public')

    def __str__(self) -> str:
        return f"{self.title}"


class Episode(models.Model):
    STATUS_CHOICES = [
        ('draft', 'Draft'),
        ('published', 'Published')
    ]

    title = models.CharField(max_length=255)
    slug = models.SlugField(max_length=250, unique_for_date='publish')
    description = models.TextField(blank=True)

    audio_file = models.FileField(upload_to=get_audio_upload_path, blank=True)
    
    audio_duration = models.PositiveIntegerField(null=True, blank=True)
    audio_size = models.PositiveIntegerField(null=True, blank=True)

    def clean(self):
        if self.audio_file:
            self.audio_duration, self.audio_size = get_audio_duration_and_size(self.audio_file)
        super().clean()

    publish = models.DateTimeField(default=timezone.now)
    created = models.DateTimeField(default=timezone.now)
    updated = models.DateTimeField(auto_now=True)

    podcast = models.ForeignKey(
        Podcast, on_delete=models.CASCADE, related_name='episodes')
    
    status = models.CharField(max_length=9, choices=STATUS_CHOICES, default='draft')

    def __str__(self) -> str:
        return f"{self.podcast} - {self.title}"


class Subscription(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    podcast = models.ForeignKey(Podcast, on_delete=models.CASCADE)


class Playback(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    episode = models.ForeignKey(Episode, on_delete=models.CASCADE)
    position = models.PositiveIntegerField(default=0)
