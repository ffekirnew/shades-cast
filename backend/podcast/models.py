from django.db import models

# Create your models here.
class Podcast(models.Model):
    name = models.CharField(max_length=20)
    url = models.CharField(max_length=20)
    description = models.CharField(null=True, blank=True)