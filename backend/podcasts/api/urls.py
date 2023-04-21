from django.urls import path
from . import views

app_name = "podcasts"
urlpatterns = [
    path('podcasts/',
         views.PodcastListView.as_view(),
         name='Podcast_list'),
    path('podcasts/<pk>/',
         views.PodcastDetailView.as_view(),
         name='Podcast_detail'),
]
