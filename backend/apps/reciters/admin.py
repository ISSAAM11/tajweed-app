from django.contrib import admin

from .models import Reciter


@admin.register(Reciter)
class ReciterAdmin(admin.ModelAdmin):
    list_display = ["slug", "name_simple", "name_arabic", "audio_type", "updated_at"]
    # The blob is large and not editable through a text widget — keep it off
    # both the list and the form.
    exclude = ["timing_db"]
    readonly_fields = ["updated_at"]
