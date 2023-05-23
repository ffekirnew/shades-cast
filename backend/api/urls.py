from django.urls import path, include

app_name = "api"

urlpatterns = [
    path('v2/', include('podcasts.urls', namespace='podcasts')),
    path('v2/users/', include('user_accounts.urls', namespace='users')),
]
