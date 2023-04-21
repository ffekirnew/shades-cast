from django.urls import path, include
from rest_framework import routers

from . import views

app_name = "podcasts"

router = routers.SimpleRouter()
router.register('podcasts', views.PodcastViewSet, basename='podcasts')
router.register('users', views.UserViewSet, basename='users')
router.register('episodes', views.EpisodeViewSet, basename='episodes')

urlpatterns = router.urls


# urlpatterns = [
#     path('podcasts/', views.PodcastListView.as_view(), name='podcast_list'),
#     path('podcasts/<pk>/', views.PodcastDetailView.as_view(), name='podcast_detail'),
#     path('users/', views.UserListView.as_view(), name='user_list'),
#     path('users/<pk>/', views.UserDetailView.as_view(), name='user_detail'),
# ]
