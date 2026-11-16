from pathlib import Path

from django.core.management.base import BaseCommand, CommandError

from apps.reciters.models import Reciter

# slug -> (name_simple, name_arabic, filename inside --dir)
RECITERS = {
    "ahmad-alnufais": (
        "Ahmad Al-Nufais",
        "أحمد النفيس",
        "surah-recitation-ahmad-alnufais.db",
    ),
    "abdul-basit-abd-us-samad": (
        "Abdul Basit Abd us-Samad",
        "عبد الباسط عبد الصمد",
        "surah-recitation-abdul-basit-abd-us-samad-murattal.db",
    ),
    "abdul-rahman-al-sudais": (
        "Abdul Rahman Al-Sudais",
        "عبد الرحمن السديس",
        "surah-recitation-abdul-rahman-al-sudais.db",
    ),
    "hady-toure": (
        "Hady Toure",
        "الهادي توري",
        "surah-recitation-hady-toure.db",
    ),
    "mishari-rashid-al-afasy": (
        "Mishari Rashid Al-Afasy",
        "مشاري راشد العفاسي",
        "surah-recitation-mishari-rashid-al-afasy-streaming.db",
    ),
    "yasser-al-dosari": (
        "Yasser Al-Dosari",
        "ياسر الدوسري",
        "surah-recitation-yasser-al-dosari.db",
    ),
}


class Command(BaseCommand):
    help = (
        "Load reciter timing .db files from a directory into the Reciter "
        "table as blobs, so the Flutter app can download them from the API "
        "instead of bundling them as assets."
    )

    def add_arguments(self, parser):
        parser.add_argument(
            "--dir",
            required=True,
            help='Directory containing the reciter .db files (e.g. the '
            'frontend "chiekh voices" folder).',
        )

    def handle(self, *args, **options):
        source_dir = Path(options["dir"])
        if not source_dir.is_dir():
            raise CommandError(f"Not a directory: {source_dir}")

        for slug, (name_simple, name_arabic, filename) in RECITERS.items():
            file_path = source_dir / filename
            if not file_path.is_file():
                self.stderr.write(self.style.WARNING(f"skip {slug}: {file_path} not found"))
                continue

            reciter, created = Reciter.objects.update_or_create(
                slug=slug,
                defaults={
                    "name_simple": name_simple,
                    "name_arabic": name_arabic,
                    "audio_type": Reciter.SURAH_LEVEL,
                    "timing_db": file_path.read_bytes(),
                },
            )
            verb = "created" if created else "updated"
            self.stdout.write(self.style.SUCCESS(f"{verb} {slug} ({file_path.stat().st_size} bytes)"))
