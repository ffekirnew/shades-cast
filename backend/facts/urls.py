from rest_framework.routers import SimpleRouter

from . import views

app_name = 'facts'

router = SimpleRouter()
router.register('', views.FactViewSet, basename='facts')

urlpatterns = router.urls
