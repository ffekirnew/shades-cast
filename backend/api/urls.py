from django.urls import path, include
from rest_framework.routers import SimpleRouter
from . import views

app_name = "api"

router = SimpleRouter()
# router.register('my-account/podcasts/created', views.UserPodcastsViewset, basename = 'user_account_podcasts')

urlpatterns = [
    path('resources/', include('podcasts.urls', namespace='podcasts')),
    path('users/', include('user_accounts.urls', namespace='users')),
    path('resources/facts/', include('facts.urls', namespace='facts')),
    path('search/<str:query>/', views.search, name='full_text_search'),
    # path('my-account/', views.UserDetailAPIView.as_view(), name='user_account'),
    # path('my-account/profile', views.UserProfileAPIView.as_view(), name='user_account_profile'),
    # path('my-account/podcasts/favorited', views.user_favorite_podcasts_list, name='user_account_favorite_podcasts'),
]

urlpatterns.extend(router.urls)
