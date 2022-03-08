from django.urls import path
from apiApp.views import loginRoute,registerRoute

urlpatterns = [
    path('login/<int:uuid>',loginRoute),
    path('register',registerRoute),
]