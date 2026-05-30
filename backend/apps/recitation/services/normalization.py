"""Letters-only normalization for Arabic word comparison.

Pure functions — no Django, HTTP or WebSocket concerns — applied to *both* the
expected Quran words and the Deepgram-recognized words so the two sides are on
equal footing before a plain string compare (see design.md §4).

Steps:
- strip all tashkeel / diacritics and Quranic annotation marks
- remove tatweel (kashida) elongation
- unify alef forms (أ إ آ ٱ → ا)
- unify taa marbuta (ة → ه)
"""

import unicodedata

# Combining marks to strip: harakat, tanwin, shadda, sukun, the dagger alef and
# the Quranic small-high annotation signs. Plus the tatweel (kashida) U+0640.
_STRIP_CODEPOINTS: frozenset[int] = frozenset(
    list(range(0x0610, 0x061B))  # Arabic signs (sallallahou, etc.)
    + list(range(0x064B, 0x0660))  # fathatan..hamza-above, shadda, sukun, superscripts
    + [0x0670]  # superscript (dagger) alef
    + list(range(0x06D6, 0x06DD))  # small high seen / ligature annotation marks
    + list(range(0x06DF, 0x06E9))  # small high rounded zero / madda etc.
    + list(range(0x06EA, 0x06EE))  # empty centre / low stop marks
    + [0x0640]  # tatweel
)

# Letter unifications applied after stripping marks.
_LETTER_MAP: dict[int, int] = {
    0x0622: 0x0627,  # آ  alef with madda     -> ا
    0x0623: 0x0627,  # أ  alef with hamza above-> ا
    0x0625: 0x0627,  # إ  alef with hamza below-> ا
    0x0671: 0x0627,  # ٱ  alef wasla          -> ا
    0x0629: 0x0647,  # ة  taa marbuta         -> ه
}


def normalize_word(word: str) -> str:
    """Reduce a single word to a bare, comparable Arabic letter sequence."""
    result: list[str] = []
    for char in unicodedata.normalize("NFC", word):
        codepoint = ord(char)
        if codepoint in _STRIP_CODEPOINTS:
            continue
        if char.isspace():
            continue
        result.append(chr(_LETTER_MAP.get(codepoint, codepoint)))
    return "".join(result).strip()


def normalize_words(words: list[str]) -> list[str]:
    """Normalize a list of words, preserving order and length."""
    return [normalize_word(word) for word in words]
