import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/responsive.dart';
import '../../logic/notes_cubit.dart';

void showAddNoteSheet(BuildContext context) {
  final ctrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final re = Responsive(context);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(re.r(24))),
    ),
    builder: (sheet) {
      final cs = Theme.of(sheet).colorScheme;
      return Padding(
        padding: EdgeInsets.only(
          left: re.w(24),
          right: re.w(24),
          top: re.h(24),
          bottom: MediaQuery.of(sheet).viewInsets.bottom + re.h(24),
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: re.w(40),
                  height: re.h(4),
                  decoration: BoxDecoration(
                    color: cs.onSurfaceVariant.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: re.h(20)),
              Text(
                'New Note',
                style: TextStyle(
                  fontSize: re.sp(22),
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                ),
              ),
              SizedBox(height: re.h(6)),
              Text(
                'Write down your thoughts',
                style: TextStyle(
                  fontSize: re.sp(14),
                  color: cs.onSurfaceVariant,
                ),
              ),
              SizedBox(height: re.h(24)),
              TextFormField(
                controller: ctrl,
                autofocus: true,
                maxLines: 4,
                minLines: 2,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: "What's on your mind?",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(bottom: 48),
                    child: Icon(Icons.sticky_note_2_outlined),
                  ),
                  filled: true,
                  fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(re.r(14)),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(re.r(14)),
                    borderSide: BorderSide(color: cs.primary, width: 1.5),
                  ),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Note cannot be empty'
                    : null,
              ),
              SizedBox(height: re.h(28)),
              FilledButton.icon(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<NotesCubit>().addNote(ctrl.text.trim());
                    Navigator.pop(sheet);
                  }
                },
                icon: const Icon(Icons.add_rounded),
                label: Text(
                  'Save Note',
                  style: TextStyle(
                    fontSize: re.sp(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: FilledButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: re.h(16)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(re.r(14)),
                  ),
                ),
              ),
              SizedBox(height: re.h(8)),
            ],
          ),
        ),
      );
    },
  );
}
