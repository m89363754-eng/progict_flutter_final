import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/attendance_cubit.dart';

void showAddAttendeeSheet(BuildContext context) {
  final nameCtrl = TextEditingController();
  final roleCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheet) {
      final cs = Theme.of(sheet).colorScheme;
      return Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(sheet).viewInsets.bottom + 24,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: cs.onSurfaceVariant.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'New Attendee',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: cs.onSurface,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Enter the attendee's details below",
                style: TextStyle(fontSize: 14, color: cs.onSurfaceVariant),
              ),
              const SizedBox(height: 24),
              _buildField(
                nameCtrl,
                'Full Name',
                'e.g. John Doe',
                Icons.person_outline_rounded,
                cs,
                true,
              ),
              const SizedBox(height: 16),
              _buildField(
                roleCtrl,
                'Role / Title',
                'e.g. Software Engineer',
                Icons.badge_outlined,
                cs,
                false,
              ),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AttendanceCubit>().addEmployee(
                      nameCtrl.text.trim(),
                      roleCtrl.text.trim(),
                    );
                    Navigator.pop(sheet);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${nameCtrl.text.trim()} added'),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.add_rounded),
                label: const Text(
                  'Add Attendee',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildField(
  TextEditingController ctrl,
  String label,
  String hint,
  IconData icon,
  ColorScheme cs,
  bool isRequired,
) {
  return TextFormField(
    controller: ctrl,
    autofocus: isRequired,
    textCapitalization: isRequired
        ? TextCapitalization.words
        : TextCapitalization.sentences,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: cs.primary, width: 1.5),
      ),
    ),
    validator: isRequired
        ? (v) => (v == null || v.trim().isEmpty) ? 'Name is required' : null
        : null,
  );
}
