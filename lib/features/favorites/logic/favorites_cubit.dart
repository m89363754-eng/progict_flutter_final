import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:equatable/equatable.dart';
import '../../../features/auth/models/book_model.dart';

class FavoritesState extends Equatable {
  final List<BookModel> books;
  const FavoritesState({this.books = const []});

  @override
  List<Object?> get props => [books];
}

class FavoritesCubit extends Cubit<FavoritesState> {
  static const _boxName = 'favorites_box';
  static const _key = 'favorites_state';

  FavoritesCubit() : super(const FavoritesState()) {
    _loadFromHive();
  }

  Future<void> _loadFromHive() async {
    final box = await Hive.openBox(_boxName);
    final raw = box.get(_key);
    if (raw != null) {
      try {
        final json = Map<String, dynamic>.from(
          jsonDecode(raw as String) as Map,
        );
        final list =
            (json['books'] as List<dynamic>?)
                ?.map((e) => BookModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [];
        emit(FavoritesState(books: list));
      } catch (_) {}
    }
  }

  Future<void> _save() async {
    final box = await Hive.openBox(_boxName);
    final data = {'books': state.books.map((b) => b.toJson()).toList()};
    await box.put(_key, jsonEncode(data));
  }

  bool isFavorite(String? bookId) =>
      bookId != null && state.books.any((b) => b.id == bookId);

  void toggleFavorite(BookModel book) {
    final exists = state.books.any((b) => b.id == book.id);
    if (exists) {
      emit(
        FavoritesState(
          books: state.books.where((b) => b.id != book.id).toList(),
        ),
      );
    } else {
      emit(FavoritesState(books: [...state.books, book]));
    }
    _save();
  }

  void removeFavorite(String? bookId) {
    if (bookId == null) return;
    emit(
      FavoritesState(books: state.books.where((b) => b.id != bookId).toList()),
    );
    _save();
  }
}
