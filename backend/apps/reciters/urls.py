from django.urls import path

from . import views

app_name = "reciters"

urlpatterns = [
    path("", views.ReciterListView.as_view(), name="list"),
    path("<slug:slug>/timing-db/", views.timing_db, name="timing-db"),
]
