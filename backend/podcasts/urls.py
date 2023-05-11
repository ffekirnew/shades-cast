from django.urls import path
from rest_framework.routers import SimpleRouter
from . import views

app_name = 'podcasts'



router = SimpleRouter()
router.register('podcasts', views.PodcastViewSet, basename='podcasts')
router.register('episodes', views.EpisodeViewSet, basename='episodes')

urlpatterns = router.urls

urlpatterns.append(
    path('podcasts/<int:podcast_id>/episodes', views.PodcastEpisodesListView.as_view(), name='podcast_episodes')
)