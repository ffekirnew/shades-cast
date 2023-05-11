from django.urls import path
from . import views


app_name = 'user_accounts'
urlpatterns = [
    path('', views.UserListView.as_view()),
    # path('<int:pk>/', views.UserDetailView.as_view()),
    path('<str:username>/', views.UserDetailView.as_view(), name='user_detail'),
    path('<str:username>/followers/', views.UserFollowersAPIView.as_view(), name='user_followers'),
    path('<str:username>/following/', views.UserFollowingAPIView.as_view(), name='user_following'),
    path('<str:username>/podcasts/', views.UserPodcastsAPIView.as_view(), name='user_podcasts'),
    path('<int:id>/profile', views.user_profile_view, name='user_profile'),
]
