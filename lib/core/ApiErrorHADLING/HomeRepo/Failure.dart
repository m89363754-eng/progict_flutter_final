import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  const Failure({required this.errorMessage});
}

class Serverfailure extends Failure {
  Serverfailure({required super.errorMessage});

  factory Serverfailure.fromDioerror(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return Serverfailure(errorMessage: "Connection timeout Error");
      case DioExceptionType.sendTimeout:
        return Serverfailure(errorMessage: "send timeout Error");
      case DioExceptionType.receiveTimeout:
        return Serverfailure(errorMessage: "receive Timeout Error");
      case DioExceptionType.badCertificate:
        return Serverfailure(errorMessage: "badCertificate Error");
      case DioExceptionType.badResponse:
        return Serverfailure.response(
          error.response!.statusCode!,
          error.response,
        );
      case DioExceptionType.cancel:
        return Serverfailure(errorMessage: "Request cancelled");
      case DioExceptionType.connectionError:
        return Serverfailure(errorMessage: "Connection Error");
      case DioExceptionType.unknown:
        return Serverfailure(errorMessage: "Unknown Error");
    }
  }

  factory Serverfailure.response(int statuscode, dynamic response) {
    if (statuscode >= 400 && statuscode <= 403) {
      return Serverfailure(errorMessage: response["error"]["message"]);
    } else if (statuscode == 404) {
      return Serverfailure(
        errorMessage: "Your response not Found, please Try Again!",
      );
    } else if (statuscode == 500) {
      return Serverfailure(
        errorMessage: "Internal Server error, please Try Again!",
      );
    } else {
      return Serverfailure(errorMessage: "Oops, there was an Error");
    }
  }
}
