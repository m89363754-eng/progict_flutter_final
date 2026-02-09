// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_14/core/ApiErrorHADLING/ApiServers2.dart';
import 'package:flutter_application_14/core/ApiErrorHADLING/HomeRepo/Failure.dart';
import 'package:flutter_application_14/core/ApiErrorHADLING/HomeRepo/Homerepo.dart';
import 'package:flutter_application_14/features/auth/models/book_model.dart';

class Implehomerepo extends Homerepo {
  Apiservers2 apiservers2;
  Implehomerepo({required this.apiservers2});

  @override
  Future<Either<Failure, List<BookModel>>> fetchBestsellerBooks() async {
    try {
      var data = await apiservers2.GetBooks(
        endpoint: "volumes?q=flutter+programming&filter=free-ebooks",
      );
      List<BookModel> booksmodel = [];
      for (var element in data["items"]) {
        booksmodel.add(BookModel.fromJson(element));
      }
      return right(booksmodel);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(Serverfailure.fromDioerror(e));
      }
      return left(Serverfailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchFeaturesBooks() async {
    try {
      var data = await apiservers2.GetBooks(
        endpoint: "volumes?q=web+development&filter=free-ebooks",
      );
      List<BookModel> booksmodel = [];
      for (var element in data["items"]) {
        booksmodel.add(BookModel.fromJson(element));
      }
      return right(booksmodel);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(Serverfailure.fromDioerror(e));
      }
      return left(Serverfailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> searchBooks(String query) async {
    try {
      var data = await apiservers2.GetBooks(
        endpoint: "volumes?q=$query&maxResults=20&filter=free-ebooks",
      );
      List<BookModel> booksmodel = [];
      for (var element in data["items"] ?? []) {
        booksmodel.add(BookModel.fromJson(element));
      }
      return right(booksmodel);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(Serverfailure.fromDioerror(e));
      }
      return left(Serverfailure(errorMessage: e.toString()));
    }
  }
}
