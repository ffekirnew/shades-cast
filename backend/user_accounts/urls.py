from django.urls import path
from . import views
from rest_framework.routers import SimpleRouter

app_name = 'user_accounts'

router = SimpleRouter()
router.register('', views.UserViewSet, basename='users')

urlpatterns = router.urls

urlpatterns.extend([
    path('<int:id>/followers/', views.UserFollowersAPIView.as_view(),
         name='user_followers'),
    path('<int:id>/following/', views.UserFollowingAPIView.as_view(),
         name='user_following'),
    path('<int:id>/podcasts-created/',
         views.UserPodcastsAPIView.as_view(), name='user_podcasts'),
    path('<int:id>/favorite-podcasts/',
         views.UserFavoritePodcastsAPIView.as_view(), name='user_favorite_podcasts'),
    path('<int:id>/profile/', views.UserProfileDetailView.as_view(),
         name='user_profile'),
    path('<int:id>/add-follow/', views.user_add_follow_view, name='user_add_follow'),
])
