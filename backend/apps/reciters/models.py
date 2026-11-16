from django.db import models


class Reciter(models.Model):
    """A Quran reciter (cheikh) and the ayah-timing SQLite database the
    Flutter app needs to play their recitation.

    The timing database used to ship as a Flutter asset per reciter, which
    bloated the app bundle. It now lives here as a blob and is downloaded by
    the app on demand, the same way ayah/surah MP3s already are.
    """

    SURAH_LEVEL = "surah_level"
    AYAH_LEVEL = "ayah_level"
    AUDIO_TYPE_CHOICES = [
        (SURAH_LEVEL, "One MP3 per surah, ayahs are timestamp segments"),
        (AYAH_LEVEL, "One MP3 per ayah"),
    ]

    slug = models.SlugField(primary_key=True, max_length=64)
    name_simple = models.CharField(max_length=128)
    name_arabic = models.CharField(max_length=128)
    audio_type = models.CharField(
        max_length=16, choices=AUDIO_TYPE_CHOICES, default=SURAH_LEVEL
    )
    timing_db = models.BinaryField(
        help_text="Raw bytes of the reciter's SQLite timing database."
    )
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ["name_simple"]

    def __str__(self):
        return self.name_simple
