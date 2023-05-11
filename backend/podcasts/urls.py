from django.urls import path
from . import views

app_name = 'podcasts'
urlpatterns = [
    path('podcasts/', views.PodcastViewSet.as_view({'get': 'list'})),
    path('podcasts/<int:podcast_id>/episodes', views.PodcastEpisodesListView.as_view(), name='podcast_episodes')
]