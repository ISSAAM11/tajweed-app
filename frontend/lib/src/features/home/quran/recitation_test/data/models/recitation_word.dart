import 'package:equatable/equatable.dart';

/// One recitable word of the surah.
///
/// [glyph] is the QPC V2 glyph code shown on screen (rendered with the
/// per-page `QPC-V2-Font-p<page>` font); [expected] is the plain Arabic
/// spelling sent to the backend, which matches it against speech-to-text.
/// The two are kept together so a verdict's `wordIndex` lines up with the
/// chip displayed at the same position.
class RecitationWord extends Equatable {
  final String glyph;
  final String expected;

  const RecitationWord({required this.glyph, required this.expected});

  @override
  List<Object?> get props => [glyph, expected];
}
