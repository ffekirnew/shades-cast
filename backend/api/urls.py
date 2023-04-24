from django.urls import path, include
from rest_framework import routers

import podcasts.views as podcasts_views
import profiles.views as profiles_views

app_name = "api"

router = routers.SimpleRouter()
router.register('podcasts', podcasts_views.PodcastViewSet, basename='podcasts')
router.register('episodes', podcasts_views.EpisodeViewSet, basename='episodes')
router.register('users', profiles_views.ProfileViewSet, basename='users')

urlpatterns = router.urls

# urlpatterns = [
#     path('podcasts/', views.PodcastListView.as_view(), name='podcast_list'),
#     path('podcasts/<pk>/', views.PodcastDetailView.as_view(), name='podcast_detail'),
#     path('users/', views.UserListView.as_view(), name='user_list'),
#     path('users/<pk>/', views.UserDetailView.as_view(), name='user_detail'),
# ]
