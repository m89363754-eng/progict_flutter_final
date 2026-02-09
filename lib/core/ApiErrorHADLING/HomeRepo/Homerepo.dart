import 'package:dartz/dartz.dart';
import 'package:flutter_application_14/core/ApiErrorHADLING/HomeRepo/Failure.dart';
import 'package:flutter_application_14/features/auth/models/book_model.dart';

abstract class Homerepo {
  Future<Either<Failure, List<BookModel>>> fetchBestsellerBooks();
  Future<Either<Failure, List<BookModel>>> fetchFeaturesBooks();
  Future<Either<Failure, List<BookModel>>> searchBooks(String query);
}
