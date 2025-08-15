import 'package:equatable/equatable.dart';

import '../../../../helpers/timestamp_helper.dart';
import '../enums/note_type.dart';

base class HandoverNote extends Equatable {
  final String id;
  final String text;
  final DateTime timestamp;
  final String authorId;
  final bool isAcknowledged;
  final NoteType type;

  bool get isEmpty => text.isEmpty;

  const HandoverNote._({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.authorId,
    required this.isAcknowledged,
    required this.type,
  });

  factory HandoverNote.acknowledged(HandoverNote note) => note.copyWith(isAcknowledged: true);

  factory HandoverNote.from(Map<String, dynamic> json) => HandoverNote._(
    id: json['id'] ?? '',
    text: json['text'] ?? '',
    timestamp: TimestampHelper.parseTimestamp(json['timestamp']),
    authorId: json['authorId'] ?? '',
    isAcknowledged: json['isAcknowledged'] ?? false,
    type: switch (json['type']) {
      'observation' => NoteType.observation,
      'incident' => NoteType.incident,
      'medication' => NoteType.medication,
      'task' => NoteType.task,
      'supplyRequest' => NoteType.supplyRequest,
      _ => NoteType.observation,
    },
  );

  HandoverNote copyWith({
    String? id,
    String? text,
    DateTime? timestamp,
    String? authorId,
    List<String>? taggedResidentIds,
    bool? isAcknowledged,
    NoteType? type,
  }) => HandoverNote._(
    id: id ?? this.id,
    text: text ?? this.text,
    timestamp: timestamp ?? this.timestamp,
    authorId: authorId ?? this.authorId,
    isAcknowledged: isAcknowledged ?? this.isAcknowledged,
    type: type ?? this.type,
  );

  @override
  List<Object?> get props => [id, text, timestamp, authorId, isAcknowledged, isEmpty];
}
