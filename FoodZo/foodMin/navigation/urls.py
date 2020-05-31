from django.contrib import admin
from django.urls import path,include
from . import views

urlpatterns = [
    path('', views.home,name = 'home'),
    path('hotelInfo/', views.hotel ,name = 'hotels'),
    path('getRoute/', views.getData,name = 'getData'),
    path('getMarker/', views.getMarkerData,name = 'getMarkerData'),
]
