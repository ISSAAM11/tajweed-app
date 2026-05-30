"""Online word alignment for live recitation (design.md §5).

Recognized words arrive as a *growing prefix*, so we cannot run a one-shot
global diff. Instead we keep a moving ``pointer`` (the next expected word not yet
committed) plus a small look-ahead window to absorb skipped words.

Two entry points mirror Deepgram's interim/final distinction:
- ``preview_words``       — interim hypothesis: emits tentative verdicts
                            (``final=False``) without mutating committed state.
- ``consume_final_words`` — finalized segment: emits committed verdicts
                            (``final=True``) and advances the pointer.

This module is pure logic (no I/O) so it is unit-testable in isolation.
"""

from dataclasses import dataclass

from .normalization import normalize_word


@dataclass(frozen=True)
class Verdict:
    """A per-word judgement, indexing the expected word list the app displays."""

    word_index: int
    is_correct: bool
    final: bool


class OnlineAligner:
    """Stateful, single-session aligner over a fixed expected word list."""

    def __init__(self, expected_words: list[str], lookahead: int = 2) -> None:
        self._expected: list[str] = [normalize_word(word) for word in expected_words]
        self.lookahead: int = lookahead
        self.pointer: int = 0

    @property
    def total(self) -> int:
        return len(self._expected)

    @property
    def finished(self) -> bool:
        return self.pointer >= self.total

    def preview_words(self, recognized: list[str]) -> list[Verdict]:
        """Tentative alignment for an interim transcript (no state change)."""
        verdicts, _ = self._align(recognized, self.pointer, final=False)
        return verdicts

    def consume_final_words(self, recognized: list[str]) -> list[Verdict]:
        """Committed alignment for a finalized transcript; advances the pointer."""
        verdicts, self.pointer = self._align(recognized, self.pointer, final=True)
        return verdicts

    def flush_remaining(self) -> list[Verdict]:
        """At session end, lock every not-yet-reached word as incorrect (skipped)."""
        verdicts = [
            Verdict(word_index=index, is_correct=False, final=True)
            for index in range(self.pointer, self.total)
        ]
        self.pointer = self.total
        return verdicts

    def _align(
        self, recognized: list[str], pointer: int, *, final: bool
    ) -> tuple[list[Verdict], int]:
        """Core alignment loop shared by preview (final=False) and commit (final=True)."""
        verdicts: list[Verdict] = []
        for raw_word in recognized:
            if pointer >= self.total:
                break  # extra recognized words beyond the surah are ignored
            word = normalize_word(raw_word)
            if not word:
                continue

            if word == self._expected[pointer]:
                verdicts.append(Verdict(pointer, True, final))
                pointer += 1
                continue

            matched_index = self._lookahead_match(word, pointer)
            if matched_index is not None:
                # Words between the pointer and the match were skipped → incorrect.
                for skipped in range(pointer, matched_index):
                    verdicts.append(Verdict(skipped, False, final))
                verdicts.append(Verdict(matched_index, True, final))
                pointer = matched_index + 1
            else:
                # No match in the window → treat the current word as misrecited.
                verdicts.append(Verdict(pointer, False, final))
                pointer += 1
        return verdicts, pointer

    def _lookahead_match(self, word: str, pointer: int) -> int | None:
        """Index of ``word`` within (pointer+1 .. pointer+lookahead), else None."""
        for step in range(1, self.lookahead + 1):
            index = pointer + step
            if index < self.total and self._expected[index] == word:
                return index
        return None
