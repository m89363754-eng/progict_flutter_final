// notes_state.dart
// ─────────────────────────────────────────────────────────────────────────────
// Immutable state for the Notes feature.
// Supports JSON round-trip for HydratedCubit persistence via Hive.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:equatable/equatable.dart';
import '../data/models/note.dart';

class NotesState extends Equatable {
  final List<Note> notes;
  final int nextId; // tracks the auto-increment ID across sessions

  const NotesState({this.notes = const [], this.nextId = 1});

  // Serialize state → JSON for HydratedCubit.
  Map<String, dynamic> toJson() => {
    'notes': notes.map((n) => n.toJson()).toList(),
    'nextId': nextId,
  };

  // Deserialize JSON → state on app restart.
  factory NotesState.fromJson(Map<String, dynamic> json) {
    final list =
        (json['notes'] as List<dynamic>?)
            ?.map((n) => Note.fromJson(n as Map<String, dynamic>))
            .toList() ??
        [];
    return NotesState(notes: list, nextId: json['nextId'] as int? ?? 1);
  }

  @override
  List<Object?> get props => [notes, nextId];
}
