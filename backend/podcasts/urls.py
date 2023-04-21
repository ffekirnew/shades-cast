from django.urls import path, include
from . import views

app_name = "podcasts"
urlpatterns = [
    path('podcasts/', views.PodcastListView.as_view(), name='podcast_list'),
    path('podcasts/<pk>/', views.PodcastDetailView.as_view(), name='podcast_detail'),
]
