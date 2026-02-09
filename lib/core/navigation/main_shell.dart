import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/attendance/logic/attendance_cubit.dart';
import '../../features/attendance/views/attendance_screen.dart';
import '../../features/books/views/books_screen.dart';
import '../../features/favorites/logic/favorites_cubit.dart';
import '../../features/favorites/views/favorites_screen.dart';
import '../../features/notes/logic/notes_cubit.dart';
import '../../features/notes/views/notes_screen.dart';
import '../../features/profile/views/profile_screen.dart';
import '../ApiErrorHADLING/ApiServers2.dart';
import '../ApiErrorHADLING/HomeRepo/ImpleHomeRepo.dart';
import '../GetFeaturesBookscubit/get_feature_books_cubit.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell>
    with SingleTickerProviderStateMixin {
  int _index = 0;
  late final AttendanceCubit _attendance;
  late final NotesCubit _notes;
  late final GetFeatureBooksCubit _books;
  late final FavoritesCubit _favorites;
  late final AnimationController _fade;

  @override
  void initState() {
    super.initState();
    _attendance = AttendanceCubit();
    _notes = NotesCubit();
    _books = GetFeatureBooksCubit(
      Implehomerepo(apiservers2: Apiservers2(dio: Dio())),
    );
    _favorites = FavoritesCubit();
    _fade = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _fade.dispose();
    _attendance.close();
    _notes.close();
    _books.close();
    _favorites.close();
    super.dispose();
  }

  void _onTab(int i) {
    if (i == _index) return;
    _fade.reverse().then((_) {
      setState(() => _index = i);
      _fade.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: BlocProvider.value(
        value: _favorites,
        child: FadeTransition(
          opacity: _fade,
          child: IndexedStack(
            index: _index,
            children: [
              BlocProvider.value(
                value: _attendance,
                child: const AttendanceScreen(),
              ),
              BlocProvider.value(value: _notes, child: const NotesScreen()),
              BlocProvider.value(value: _books, child: const BooksScreen()),
              const FavoritesScreen(),
              const ProfileScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: cs.primary.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: NavigationBar(
          height: 72,
          selectedIndex: _index,
          animationDuration: const Duration(milliseconds: 400),
          onDestinationSelected: _onTab,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.how_to_reg_outlined),
              selectedIcon: Icon(Icons.how_to_reg),
              label: 'Attendance',
            ),
            NavigationDestination(
              icon: Icon(Icons.note_alt_outlined),
              selectedIcon: Icon(Icons.note_alt),
              label: 'Notes',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book),
              label: 'Books',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_outline),
              selectedIcon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
