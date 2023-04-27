from django.urls import path, include
from rest_framework import routers

import podcasts.views as podcasts_views
import user_accounts.views as user_accounts_views

app_name = "api"

router = routers.SimpleRouter()
router.register('podcasts', podcasts_views.PodcastViewSet, basename='podcasts')
router.register('episodes', podcasts_views.EpisodeViewSet, basename='episodes')
router.register('users', user_accounts_views.UserViewSet, basename='users')
router.register('contact', user_accounts_views.ContactViewSet, basename='followings')

urlpatterns = [
    path('', include(router.urls)),
]
