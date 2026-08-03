import 'dart:convert';

import 'package:equatable/equatable.dart';

/// A per-word verdict pushed by the backend over the recitation WebSocket.
///
/// `wordIndex` indexes the expected word list the screen already displays.
/// `isFinal == false` is a tentative preview; `true` locks the verdict.
class WordVerdictModel extends Equatable {
  final int wordIndex;
  final bool isCorrect;
  final bool isFinal;

  const WordVerdictModel({
    required this.wordIndex,
    required this.isCorrect,
    required this.isFinal,
  });

  factory WordVerdictModel.fromJson(Map<String, dynamic> json) =>
      WordVerdictModel(
        wordIndex: json['word_index'] as int,
        isCorrect: json['is_correct'] as bool,
        isFinal: json['final'] as bool,
      );

  @override
  List<Object?> get props => [wordIndex, isCorrect, isFinal];
}

/// Sealed view of every message the backend can send (design.md §3).
sealed class RecitationServerMessage {
  const RecitationServerMessage();

  /// Parses one inbound WebSocket text frame; returns null for anything
  /// unrecognized so callers can simply ignore it.
  static RecitationServerMessage? parse(String raw) {
    final Map<String, dynamic> json;
    try {
      json = jsonDecode(raw) as Map<String, dynamic>;
    } on FormatException {
      return null;
    }
    return switch (json['type']) {
      'verdict' => VerdictMessage(WordVerdictModel.fromJson(json)),
      'done' => const DoneMessage(),
      'error' => ErrorMessage((json['reason'] as String?) ?? 'unknown'),
      _ => null,
    };
  }
}

class VerdictMessage extends RecitationServerMessage {
  final WordVerdictModel verdict;
  const VerdictMessage(this.verdict);
}

class DoneMessage extends RecitationServerMessage {
  const DoneMessage();
}

class ErrorMessage extends RecitationServerMessage {
  final String reason;
  const ErrorMessage(this.reason);
}
