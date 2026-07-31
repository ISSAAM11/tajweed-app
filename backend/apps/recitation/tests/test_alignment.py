from django.test import SimpleTestCase

from apps.recitation.services.alignment import OnlineAligner, Verdict

# First four words of Al-Fatiha's basmala (already normalized form).
EXPECTED = ["بسم", "الله", "الرحمن", "الرحيم"]


class OnlineAlignerTests(SimpleTestCase):
    def test_exact_sequence_marks_all_correct_and_advances(self):
        aligner = OnlineAligner(EXPECTED)
        verdicts = aligner.consume_final_words(["بسم", "الله"])
        self.assertEqual(verdicts, [Verdict(0, True, True), Verdict(1, True, True)])
        self.assertEqual(aligner.pointer, 2)

    def test_skipped_word_marked_incorrect_via_lookahead(self):
        aligner = OnlineAligner(EXPECTED)
        verdicts = aligner.consume_final_words(["بسم", "الرحمن"])  # skipped "الله"
        self.assertEqual(
            verdicts,
            [Verdict(0, True, True), Verdict(1, False, True), Verdict(2, True, True)],
        )
        self.assertEqual(aligner.pointer, 3)

    def test_unmatched_word_marks_current_incorrect(self):
        aligner = OnlineAligner(EXPECTED)
        verdicts = aligner.consume_final_words(["خطا"])  # matches nothing in window
        self.assertEqual(verdicts, [Verdict(0, False, True)])
        self.assertEqual(aligner.pointer, 1)

    def test_preview_is_tentative_and_does_not_advance(self):
        aligner = OnlineAligner(EXPECTED)
        verdicts = aligner.preview_words(["بسم"])
        self.assertEqual(verdicts, [Verdict(0, True, False)])
        self.assertEqual(aligner.pointer, 0)

    def test_flush_remaining_locks_unreached_words_incorrect(self):
        aligner = OnlineAligner(EXPECTED)
        aligner.consume_final_words(["بسم"])
        verdicts = aligner.flush_remaining()
        self.assertEqual(
            verdicts,
            [Verdict(1, False, True), Verdict(2, False, True), Verdict(3, False, True)],
        )
        self.assertTrue(aligner.finished)

    def test_recognized_words_are_normalized_before_compare(self):
        aligner = OnlineAligner(EXPECTED)
        verdicts = aligner.consume_final_words(["بِسْمِ"])  # tashkeel on input
        self.assertEqual(verdicts, [Verdict(0, True, True)])

    def test_words_beyond_surah_are_ignored(self):
        aligner = OnlineAligner(["بسم"])
        verdicts = aligner.consume_final_words(["بسم", "الله", "الرحمن"])
        self.assertEqual(verdicts, [Verdict(0, True, True)])
        self.assertTrue(aligner.finished)
