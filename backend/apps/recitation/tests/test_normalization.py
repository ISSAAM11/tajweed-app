from django.test import SimpleTestCase

from apps.recitation.services.normalization import normalize_word, normalize_words


class NormalizationTests(SimpleTestCase):
    def test_strips_tashkeel(self):
        self.assertEqual(normalize_word("بِسْمِ"), "بسم")
        self.assertEqual(normalize_word("الْحَمْدُ"), "الحمد")

    def test_unifies_alef_forms(self):
        self.assertEqual(normalize_word("أَحْمَد"), "احمد")  # hamza above
        self.assertEqual(normalize_word("إِيمان"), "ايمان")  # hamza below
        self.assertEqual(normalize_word("آمَنوا"), "امنوا")  # madda

    def test_unifies_taa_marbuta(self):
        self.assertEqual(normalize_word("صَلاة"), "صلاه")

    def test_removes_tatweel(self):
        self.assertEqual(normalize_word("الرحـــمن"), "الرحمن")

    def test_blank_input_yields_empty_string(self):
        self.assertEqual(normalize_word("   "), "")

    def test_normalize_words_preserves_order_and_length(self):
        self.assertEqual(
            normalize_words(["الْحَمْدُ", "لِلَّهِ"]),
            ["الحمد", "لله"],
        )
