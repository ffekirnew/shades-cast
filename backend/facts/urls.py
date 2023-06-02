from django.urls import path

from . import views

app_name = 'facts'
urlpatterns = [
    path('', views.FactsListView.as_view(), name='facts_list_create_view'),
    path('<int:pk>/', views.FactRetrieveUpdateView.as_view(),
         name='facts_list_create_view'),
    path('random-fact/', views.get_random_fact, name='get_random_fact'),
]
