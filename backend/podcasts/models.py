from django.db import models
from django.contrib.auth import get_user_model
from django.utils import timezone
from django.urls import reverse
from django.utils.text import slugify

from .utils import get_audio_duration_and_size, get_audio_upload_path, get_image_upload_path

from profiles.models import Profile

class Podcast(models.Model):
    STATUS_CHOICES = [
        ('private', 'Private'),
        ('public', 'Public')
    ]

    creator = models.ForeignKey(Profile, on_delete=models.CASCADE, related_name='podcasts_created')
    title = models.CharField(max_length=255)
    slug = models.SlugField(max_length=250, unique='publish')
    description = models.TextField(blank=True)

    cover_image = models.ImageField(
        upload_to=get_image_upload_path, blank=True)

    category = models.CharField(max_length=255, blank=True)

    publish = models.DateTimeField(default=timezone.now)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    status = models.CharField(max_length=7,
                              choices=STATUS_CHOICES,
                              default='public')

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.title)
        super().save(*args, **kwargs)

    def __str__(self) -> str:
        return f"{self.title}"

    def get_absolute_url(self):
        return reverse('podcasts:podcast_detail',
                       args=[self.slug])


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
            self.audio_duration, self.audio_size = get_audio_duration_and_size(
                self.audio_file)
        super().clean()

    publish = models.DateTimeField(default=timezone.now)
    created = models.DateTimeField(default=timezone.now)
    updated = models.DateTimeField(auto_now=True)

    podcast = models.ForeignKey(
        Podcast, on_delete=models.CASCADE, related_name='episodes')

    status = models.CharField(
        max_length=9, choices=STATUS_CHOICES, default='draft')

    def __str__(self) -> str:
        return f"{self.podcast} - {self.title}"


class Subscription(models.Model):
    user = models.ForeignKey(Profile, on_delete=models.CASCADE)
    podcast = models.ForeignKey(Podcast, on_delete=models.CASCADE)


class Playback(models.Model):
    user = models.ForeignKey(Profile, on_delete=models.CASCADE)
    episode = models.ForeignKey(Episode, on_delete=models.CASCADE)
    position = models.PositiveIntegerField(default=0)


class Following(models.Model):
    user_from = models.ForeignKey('auth.User',
                                  related_name='rel_from_set',
                                  on_delete=models.CASCADE)
    user_to = models.ForeignKey('auth.User',
                                related_name='rel_to_set',
                                on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True,
                                   db_index=True)

    class Meta:
        ordering = ('-created',)

    def __str__(self):
        return f'{self.user_from} follows {self.user_to}'


user_model = get_user_model()
user_model.add_to_class('following',
                        models.ManyToManyField('self',
                                               through=Following,
                                               related_name='followers',
                                               symmetrical=False))
