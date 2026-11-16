from django.http import HttpResponse
from django.shortcuts import get_object_or_404
from rest_framework import generics
from rest_framework.decorators import api_view

from .models import Reciter
from .serializers import ReciterSerializer


class ReciterListView(generics.ListAPIView):
    """GET /api/reciters/ — catalog the Flutter app syncs on startup to learn
    which reciters exist and where to download each one's timing database."""

    queryset = Reciter.objects.all()
    serializer_class = ReciterSerializer


@api_view(["GET"])
def timing_db(request, slug):
    """GET /api/reciters/<slug>/timing-db/ — raw SQLite bytes for one reciter."""
    reciter = get_object_or_404(Reciter, slug=slug)
    response = HttpResponse(
        bytes(reciter.timing_db), content_type="application/x-sqlite3"
    )
    response["Content-Disposition"] = f'attachment; filename="{slug}.db"'
    return response
