import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';

void showEditNoteSheet(
  BuildContext context, {
  required String content,
  required ValueChanged<String> onSave,
}) {
  final ctrl = TextEditingController(text: content);
  final formKey = GlobalKey<FormState>();
  final cs = Theme.of(context).colorScheme;
  final re = Responsive(context);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(re.r(24))),
    ),
    builder: (sheet) => Padding(
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
              'Edit Note',
              style: TextStyle(
                fontSize: re.sp(22),
                fontWeight: FontWeight.w700,
                color: cs.onSurface,
              ),
            ),
            SizedBox(height: re.h(24)),
            TextFormField(
              controller: ctrl,
              autofocus: true,
              maxLines: 4,
              minLines: 2,
              decoration: InputDecoration(
                hintText: 'Update your note...',
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
                  onSave(ctrl.text.trim());
                  Navigator.pop(sheet);
                }
              },
              icon: const Icon(Icons.check_rounded),
              label: Text(
                'Save Changes',
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
    ),
  );
}
