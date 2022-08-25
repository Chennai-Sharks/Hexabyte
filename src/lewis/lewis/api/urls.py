"""lewis URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from . import views,item_views,next_views

urlpatterns = [
    path('admin/', admin.site.urls), 
    path('data_collection/', views.data_collection),
    path('item_addition/', item_views.item_addition),
    path('item_get/<str:id>/',item_views.item_get),
    path('item_edit/<str:id>/',item_views.item_edit),
    path('product_search/', views.product_search),
    path('combo_buy/', item_views.combo_buy),
    path('purchase_item/', views.purchase_item),
    path('item_rating/', views.item_rating),
    path('recomm/<str:phone>/', views.recomm),  
    path('nearest/<str:phone>/', views.nearest),    
    path('live_orders/<str:phone>/', next_views.live_orders),    
    path('profile_page/<str:phone>/', next_views.profile_page), 
    path('producer_items/<str:phone>/', next_views.producer_items),  
    path('customer_orders/<str:phone>/', next_views.customer_orders),  
]