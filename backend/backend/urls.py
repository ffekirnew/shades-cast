from django.contrib import admin
from django.urls import include, path

from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi

API_TITLE = 'Blog API'  
API_DESCRIPTION = 'A Web API for creating and editing blog posts.'

schema_view = get_schema_view(
    openapi.Info(
        title="Podcast API",
        default_version="v1",
        description="Provides backend service to a podcast app.",
        # terms_of_service="https://www.google.com/policies/terms/",
        # contact=openapi.Contact(email="ffekirnew0808@gmail.com"),
        license=openapi.License(name="MIT License"),
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('podcasts.urls', namespace='podcasts')),

    # section for Adding log in to the browsable API - nothing fancy really
    path('api-auth/', include('rest_framework.urls')),

    # to handle user authentication
    path('api/auth/', include('dj_rest_auth.urls')),
    path('api/auth/signup/', include('dj_rest_auth.registration.urls')),

    # to handle documentation and api schema views
    path('docs/', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),
]
