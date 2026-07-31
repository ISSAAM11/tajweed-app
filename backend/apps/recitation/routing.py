from django.urls import path

from .consumers import RecitationConsumer

websocket_urlpatterns = [
    path("ws/recitation/", RecitationConsumer.as_asgi()),
]
