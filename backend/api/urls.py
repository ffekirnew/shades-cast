from django.urls import path, include
from . import views

app_name = "api"

urlpatterns = [
    path('', include('podcasts.urls', namespace='podcasts')),
    path('users/', include('user_accounts.urls', namespace='users')),
    path('facts/', include('facts.urls', namespace='facts')),
    path('search/<str:query>/', views.search, name='full_text_search'),
]
