from django.urls import path, include

app_name = "api"

urlpatterns = [
    path('', include('podcasts.urls', namespace='podcasts')),
    path('users/', include('user_accounts.urls', namespace='users')),
]
