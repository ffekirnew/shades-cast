from django.shortcuts import render, get_object_or_404, get_list_or_404
from .models import Podcast, Episode


def podcast_list(request):
    podcasts = Podcast.objects.all()

    return render(request, 'podcasts/podcast/list.html', {
        "podcasts": podcasts
    })


def podcast_detail(request, podcast_slug):
    podcast = get_object_or_404(Podcast, slug=podcast_slug,
                                status='public',)
    episodes = get_list_or_404(Episode, podcast__slug=podcast_slug)

    return render(request, 'podcasts/podcast/detail.html', {
        "podcast": podcast,
        "episodes": episodes
    })
