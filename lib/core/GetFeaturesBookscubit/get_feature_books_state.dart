part of 'get_feature_books_cubit.dart';

sealed class GetFeatureBooksState extends Equatable {
  const GetFeatureBooksState();

  @override
  List<Object> get props => [];
}

final class GetFeatureBooksInitial extends GetFeatureBooksState {}

final class GetFeatureBooksLoading extends GetFeatureBooksState {}

final class GetFeatureBooksSuccess extends GetFeatureBooksState {
  final List<BookModel> books;

  GetFeatureBooksSuccess({required this.books});
}

final class GetFeatureBooksFailure extends GetFeatureBooksState {
  final String errorMessage;

  GetFeatureBooksFailure({required this.errorMessage});
}
