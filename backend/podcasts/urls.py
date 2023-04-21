from django.urls import path, include
from . import views

app_name = "podcasts"
urlpatterns = [
    path('', views.podcast_list, name='podcast_list'),
    path('<slug:podcast_slug>/',
         views.podcast_detail,
         name='podcast_detail'),
    path('api/', include("podcasts.api.urls", namespace='api')),
]
