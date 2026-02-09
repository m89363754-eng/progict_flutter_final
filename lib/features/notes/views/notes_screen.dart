import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/blue_header.dart';
import '../logic/notes_cubit.dart';
import '../logic/notes_state.dart';
import 'widgets/note_tile.dart';
import 'widgets/notes_add_sheet.dart';
import 'widgets/notes_empty_state.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Column(
        children: [
          BlueHeader(
            title: 'Notes',
            trailing: BlocBuilder<NotesCubit, NotesState>(
              builder: (_, state) {
                if (state.notes.isEmpty) return const SizedBox.shrink();
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${state.notes.length}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<NotesCubit, NotesState>(
              builder: (ctx, state) {
                if (state.notes.isEmpty) {
                  return NotesEmptyState(
                    onAdd: () => showAddNoteSheet(context),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                  itemCount: state.notes.length,
                  itemBuilder: (_, i) {
                    final note = state.notes[state.notes.length - 1 - i];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: NoteTile(
                        note: note,
                        onEdit: (c) =>
                            ctx.read<NotesCubit>().editNote(note.id, c),
                        onDelete: () =>
                            ctx.read<NotesCubit>().deleteNote(note.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAddNoteSheet(context),
        icon: const Icon(Icons.edit_note_rounded),
        label: const Text('New Note'),
      ),
    );
  }
}
