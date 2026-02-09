import 'package:flutter/material.dart';
import '../../data/models/employee.dart';

class EmployeeTile extends StatelessWidget {
  final Employee employee;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const EmployeeTile({
    super.key,
    required this.employee,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final p = employee.isPresent;

    return Dismissible(
      key: ValueKey(employee.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: const Color(0xFFC62828),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.delete_outline_rounded,
          color: Colors.white,
          size: 28,
        ),
      ),
      confirmDismiss: (_) => _confirmDelete(context),
      onDismissed: (_) => onDelete(),
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: p
                ? const Color(0xFF2E7D32).withValues(alpha: 0.3)
                : cs.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onToggle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                _Avatar(initials: employee.initials, isPresent: p),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: cs.onSurface,
                        ),
                      ),
                      if (employee.role.isNotEmpty) ...[
                        const SizedBox(height: 3),
                        Text(
                          employee.role,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                _Badge(isPresent: p),
                const SizedBox(width: 8),
                Switch.adaptive(
                  value: p,
                  activeTrackColor: const Color(
                    0xFF2E7D32,
                  ).withValues(alpha: 0.35),
                  activeThumbColor: const Color(0xFF2E7D32),
                  inactiveTrackColor: cs.surfaceContainerHighest,
                  inactiveThumbColor: cs.outline,
                  onChanged: (_) => onToggle(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Remove Attendee'),
        content: Text('Remove ${employee.name} from the list?'),
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
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String initials;
  final bool isPresent;
  const _Avatar({required this.initials, required this.isPresent});

  @override
  Widget build(BuildContext context) {
    final bg = isPresent
        ? const Color(0xFF2E7D32).withValues(alpha: 0.15)
        : Theme.of(context).colorScheme.surfaceContainerHighest;
    final fg = isPresent
        ? const Color(0xFF2E7D32)
        : Theme.of(context).colorScheme.onSurfaceVariant;
    return CircleAvatar(
      radius: 22,
      backgroundColor: bg,
      child: Text(
        initials,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: fg),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final bool isPresent;
  const _Badge({required this.isPresent});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isPresent
            ? const Color(0xFF2E7D32).withValues(alpha: 0.12)
            : const Color(0xFFC62828).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isPresent ? 'Present' : 'Absent',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: isPresent ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
        ),
      ),
    );
  }
}
