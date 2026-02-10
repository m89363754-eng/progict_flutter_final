import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';
import '../../data/models/note.dart';
import 'note_edit_sheet.dart';

class NoteTile extends StatelessWidget {
  final Note note;
  final ValueChanged<String> onEdit;
  final VoidCallback onDelete;

  const NoteTile({
    super.key,
    required this.note,
    required this.onEdit,
    required this.onDelete,
  });

  static const _accents = [
    Color(0xFF1565C0),
    Color(0xFF1976D2),
    Color(0xFF2196F3),
    Color(0xFF0D47A1),
    Color(0xFF42A5F5),
    Color(0xFF0277BD),
  ];

  Color get _accent => _accents[note.id % _accents.length];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final re = Responsive(context);
    return Dismissible(
      key: ValueKey(note.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: re.w(24)),
        decoration: BoxDecoration(
          color: const Color(0xFFC62828),
          borderRadius: BorderRadius.circular(re.r(16)),
        ),
        child: Icon(
          Icons.delete_outline_rounded,
          color: Colors.white,
          size: re.icon(28),
        ),
      ),
      confirmDismiss: (_) => showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure you want to delete this note?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFC62828),
              ),
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
      onDismissed: (_) => onDelete(),
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(re.r(16)),
          border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(re.r(16)),
          onTap: () =>
              showEditNoteSheet(context, content: note.content, onSave: onEdit),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: re.w(5),
                  decoration: BoxDecoration(
                    color: _accent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(re.r(16)),
                      bottomLeft: Radius.circular(re.r(16)),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                      re.w(14),
                      re.h(14),
                      re.w(8),
                      re.h(14),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.content,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: re.sp(15),
                            fontWeight: FontWeight.w500,
                            color: cs.onSurface,
                            height: 1.4,
                          ),
                        ),
                        if (note.timeAgo.isNotEmpty) ...[
                          SizedBox(height: re.h(8)),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule_rounded,
                                size: re.icon(13),
                                color: cs.onSurfaceVariant.withValues(
                                  alpha: 0.6,
                                ),
                              ),
                              SizedBox(width: re.w(4)),
                              Text(
                                note.timeAgo,
                                style: TextStyle(
                                  fontSize: re.sp(12),
                                  color: cs.onSurfaceVariant.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        size: re.icon(20),
                        color: _accent,
                      ),
                      tooltip: 'Edit',
                      onPressed: () => showEditNoteSheet(
                        context,
                        content: note.content,
                        onSave: onEdit,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        size: re.icon(20),
                        color: cs.error.withValues(alpha: 0.7),
                      ),
                      tooltip: 'Delete',
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
