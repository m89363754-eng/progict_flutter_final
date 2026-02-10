import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_14/core/ApiErrorHADLING/HomeRepo/ImpleHomeRepo.dart';
import 'package:flutter_application_14/features/auth/models/book_model.dart';

part 'get_feature_books_state.dart';

class GetFeatureBooksCubit extends Cubit<GetFeatureBooksState> {
  GetFeatureBooksCubit(this.implehomerepo) : super(GetFeatureBooksInitial());
  Implehomerepo implehomerepo;

  Future<void> getFeaturebooks() async {
    emit(GetFeatureBooksLoading());
    var books = await implehomerepo.fetchFeaturesBooks();
    books.fold(
      (failure) {
        emit(GetFeatureBooksFailure(errorMessage: failure.errorMessage));
      },
      (books) {
        emit(GetFeatureBooksSuccess(books: books));
      },
    );
  }

  Future<void> searchBooks(String query) async {
    emit(GetFeatureBooksLoading());
    var result = await implehomerepo.searchBooks(query);
    result.fold(
      (failure) {
        emit(GetFeatureBooksFailure(errorMessage: failure.errorMessage));
      },
      (books) {
        emit(GetFeatureBooksSuccess(books: books));
      },
    );
  }
}
