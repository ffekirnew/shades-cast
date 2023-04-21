from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('podcasts.urls', namespace='podcasts')),
    
    # section for Adding log in to the browsable API - nothing fancy really
    path('api-auth/', include('rest_framework.urls')),

    # to handle user authentication
    path('api/auth/', include('dj_rest_auth.urls')), 
    path('api/auth/signup/', include('dj_rest_auth.registration.urls')), 
]
