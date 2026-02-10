import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/blue_header.dart';
import '../../auth/AuthCubit/cubit/auth_cubit_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final re = Responsive(context);
    final cubit = context.read<AuthCubitCubit>();
    final userName = cubit.userName;
    final email = FirebaseAuth.instance.currentUser?.email ?? 'No email';

    return Column(
      children: [
        const BlueHeader(title: 'Profile'),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: re.w(24),
              vertical: re.h(32),
            ),
            child: Column(
              children: [
                // ── Avatar ──
                CircleAvatar(
                  radius: re.w(52),
                  backgroundColor: cs.primary.withValues(alpha: 0.12),
                  child: Text(
                    _initials(userName),
                    style: TextStyle(
                      fontSize: re.sp(36),
                      fontWeight: FontWeight.w800,
                      color: cs.primary,
                    ),
                  ),
                ),
                SizedBox(height: re.h(18)),

                // ── Name ──
                Text(
                  userName,
                  style: TextStyle(
                    fontSize: re.sp(22),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A2E),
                  ),
                ),
                SizedBox(height: re.h(6)),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: re.sp(14),
                    color: const Color(0xFF1A1A2E).withValues(alpha: 0.5),
                  ),
                ),
                SizedBox(height: re.h(40)),

                // ── Info Card ──
                _InfoCard(
                  children: [
                    _InfoTile(
                      icon: Icons.person_outline,
                      label: 'Name',
                      value: userName,
                    ),
                    const Divider(),
                    _InfoTile(
                      icon: Icons.email_outlined,
                      label: 'Email',
                      value: email,
                    ),
                  ],
                ),
                SizedBox(height: re.h(32)),

                // ── Sign Out Button ──
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => _confirmSignOut(context),
                    icon: const Icon(Icons.logout_rounded),
                    label: const Text('Sign Out'),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFD32F2F),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: re.h(16)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(re.r(14)),
                      ),
                      textStyle: TextStyle(
                        fontSize: re.sp(16),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }
}

// ── Private widgets ──

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final re = Responsive(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(re.r(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: re.w(20), vertical: re.h(16)),
      child: Column(children: children),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final re = Responsive(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: re.h(10)),
      child: Row(
        children: [
          Icon(icon, color: cs.primary, size: re.icon(22)),
          SizedBox(width: re.w(14)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: re.sp(12),
                  color: const Color(0xFF1A1A2E).withValues(alpha: 0.5),
                ),
              ),
              SizedBox(height: re.h(2)),
              Text(
                value,
                style: TextStyle(
                  fontSize: re.sp(15),
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A2E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Sign-out confirmation dialog ──

void _confirmSignOut(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Sign Out'),
      content: const Text('Are you sure you want to sign out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () async {
            Navigator.pop(ctx);
            await context.read<AuthCubitCubit>().signOut();
            if (context.mounted) {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil(AppRoutes.signIn, (_) => false);
            }
          },
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFFD32F2F),
          ),
          child: const Text('Sign Out'),
        ),
      ],
    ),
  );
}
