from django.urls import path, include
from . import views
from . import api

app_name = "podcast"
urlpatterns = [
    path("api/", include("podcasts.api.urls", namespace='api')),
]