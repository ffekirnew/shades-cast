from django.urls import path
from rest_framework.routers import SimpleRouter

from . import views

app_name = 'podcasts'

router = SimpleRouter()
router.register('podcasts', views.PodcastViewSet, basename='podcasts')
router.register('episodes', views.EpisodeViewSet, basename='episodes')

urlpatterns = router.urls

urlpatterns.extend([
    path('podcasts/<int:id>/episodes',
         views.PodcastEpisodesListView.as_view(), name='podcast_episodes'),
    path('podcasts/<int:id>/add-favorite',
         views.podcast_add_favorite, name='podcast_add_favorite'),
    path('podcasts/<int:id>/favorited-by',
         views.podcast_favorited_by, name='podcast_add_favorite'),
    path('podcasts/categories/<slug:category_slug>',
         views.podcast_list_by_categories, name='podcast_categories'),
    path('episodes/tags/<slug:tag_slug>',
         views.episode_list_by_tags, name='episode_tags'),
])
