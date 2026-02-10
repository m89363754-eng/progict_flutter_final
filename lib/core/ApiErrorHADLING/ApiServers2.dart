// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

class Apiservers2 {
  Dio dio;
  Apiservers2({required this.dio});

  final String baseurl = "https://www.googleapis.com/books/v1/";

  Future<Map<String, dynamic>> GetBooks({required String endpoint}) async {
    Response response = await dio.get("$baseurl$endpoint");
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception("Status Code: ${response.statusCode}");
    }
  }
}
