from django.urls import reverse
from rest_framework import serializers

from .models import Reciter


class ReciterSerializer(serializers.ModelSerializer):
    """Metadata only — the timing database itself is fetched separately via
    `timing_db_url` so the list response stays small."""

    timing_db_url = serializers.SerializerMethodField()

    class Meta:
        model = Reciter
        fields = [
            "slug",
            "name_simple",
            "name_arabic",
            "audio_type",
            "timing_db_url",
            "updated_at",
        ]

    def get_timing_db_url(self, obj):
        path = reverse("reciters:timing-db", args=[obj.slug])
        request = self.context.get("request")
        return request.build_absolute_uri(path) if request else path
