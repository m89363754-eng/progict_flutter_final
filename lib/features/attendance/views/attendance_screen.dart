import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/blue_header.dart';
import '../logic/attendance_cubit.dart';
import '../logic/attendance_state.dart';
import 'widgets/attendance_add_sheet.dart';
import 'widgets/attendance_empty_state.dart';
import 'widgets/attendance_summary_bar.dart';
import 'widgets/employee_tile.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animCtrl;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: Column(
        children: [
          BlueHeader(
            title: 'Attendees',
            trailing: BlocBuilder<AttendanceCubit, AttendanceState>(
              builder: (ctx, state) {
                if (state.employees.isEmpty) return const SizedBox.shrink();
                return _PopupMenu(cubit: ctx.read<AttendanceCubit>());
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<AttendanceCubit, AttendanceState>(
              builder: (ctx, state) {
                if (state.employees.isEmpty) {
                  return AttendanceEmptyState(
                    onAdd: () => showAddAttendeeSheet(context),
                  );
                }
                final present = state.employees
                    .where((e) => e.isPresent)
                    .length;
                return Column(
                  children: [
                    AttendanceSummaryBar(
                      present: present,
                      absent: state.employees.length - present,
                      total: state.employees.length,
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                        itemCount: state.employees.length,
                        itemBuilder: (_, i) {
                          final d = (i * 0.07).clamp(0.0, 0.6);
                          final anim = CurvedAnimation(
                            parent: _animCtrl,
                            curve: Interval(
                              d,
                              (d + 0.4).clamp(0.0, 1.0),
                              curve: Curves.easeOutCubic,
                            ),
                          );
                          return FadeTransition(
                            opacity: anim,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0.05, 0),
                                end: Offset.zero,
                              ).animate(anim),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: EmployeeTile(
                                  employee: state.employees[i],
                                  onToggle: () => ctx
                                      .read<AttendanceCubit>()
                                      .toggleAttendance(state.employees[i].id),
                                  onDelete: () => ctx
                                      .read<AttendanceCubit>()
                                      .removeEmployee(state.employees[i].id),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAddAttendeeSheet(context),
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: const Text('Add Attendee'),
      ),
    );
  }
}

class _PopupMenu extends StatelessWidget {
  final AttendanceCubit cubit;
  const _PopupMenu({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onSelected: (v) {
        if (v == 'all_present') cubit.markAllPresent();
        if (v == 'all_absent') cubit.markAllAbsent();
        if (v == 'clear_all') _confirmClear(context);
      },
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: 'all_present',
          child: Row(
            children: [
              Icon(Icons.check_circle_outline, size: 20),
              SizedBox(width: 12),
              Text('Mark all present'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'all_absent',
          child: Row(
            children: [
              Icon(Icons.highlight_off, size: 20),
              SizedBox(width: 12),
              Text('Mark all absent'),
            ],
          ),
        ),
        PopupMenuDivider(),
        PopupMenuItem(
          value: 'clear_all',
          child: Row(
            children: [
              Icon(
                Icons.delete_sweep_outlined,
                size: 20,
                color: Color(0xFFC62828),
              ),
              SizedBox(width: 12),
              Text('Clear all', style: TextStyle(color: Color(0xFFC62828))),
            ],
          ),
        ),
      ],
    );
  }

  void _confirmClear(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear All Attendees'),
        content: const Text(
          'This will remove everyone from the list. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              cubit.clearAll();
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('All attendees cleared'),
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFC62828),
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}
