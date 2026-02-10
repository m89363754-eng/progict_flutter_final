 
import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../data/models/note.dart';
import 'notes_state.dart';

class NotesCubit extends HydratedCubit<NotesState> {
  NotesCubit() : super(const NotesState());

  void addNote(String content) {
    if (content.trim().isEmpty) return;
    final note = Note(
      id: state.nextId,
      content: content.trim(),
      createdAt: DateTime.now().toIso8601String(),
    );
    emit(NotesState(notes: [...state.notes, note], nextId: state.nextId + 1));
  }

  void editNote(int id, String newContent) {
    if (newContent.trim().isEmpty) return;
    final updated = state.notes.map((n) {
      if (n.id == id) return n.copyWith(content: newContent.trim());
      return n;
    }).toList();
    emit(NotesState(notes: updated, nextId: state.nextId));
  }

  void deleteNote(int id) {
    final updated = state.notes.where((n) => n.id != id).toList();
    emit(NotesState(notes: updated, nextId: state.nextId));
  }

  @override
  Map<String, dynamic>? toJson(NotesState state) => state.toJson();

  @override
  NotesState? fromJson(Map<String, dynamic> json) => NotesState.fromJson(json);
}
