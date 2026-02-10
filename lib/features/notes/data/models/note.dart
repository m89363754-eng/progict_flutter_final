// note.dart
// ─────────────────────────────────────────────────────────────────────────────
// Domain model for a note. Supports JSON serialization for HydratedCubit.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int id;
  final String content;
  final String createdAt;

  const Note({required this.id, required this.content, this.createdAt = ''});

  Note copyWith({int? id, String? content, String? createdAt}) {
    return Note(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'content': content,
    'createdAt': createdAt,
  };

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id: json['id'] as int,
    content: json['content'] as String,
    createdAt: json['createdAt'] as String? ?? '',
  );

  String get timeAgo {
    if (createdAt.isEmpty) return '';
    final created = DateTime.tryParse(createdAt);
    if (created == null) return '';
    final diff = DateTime.now().difference(created);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${created.day}/${created.month}/${created.year}';
  }

  @override
  List<Object?> get props => [id, content, createdAt];
}
