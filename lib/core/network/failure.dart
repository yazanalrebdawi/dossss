
import 'package:dio/dio.dart';

class Failure {
  final int? statusCode;
  final String message;

  Failure({
    this.statusCode = -1,
    required this.message,
  });

  factory Failure.handleError(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return Failure(
          message:
              "Connection timeout. Please check your internet connection and try again.",
        );
      case DioExceptionType.sendTimeout:
        return Failure(
          message: "Request sending timeout. Please try again later.",
        );
      case DioExceptionType.receiveTimeout:
        return Failure(
          message: "Response receiving timeout. Please try again later.",
        );
      case DioExceptionType.badCertificate:
        return Failure(
          message: "Invalid certificate. Please contact support.",
        );
      case DioExceptionType.badResponse:
        return Failure(
          message: exception.response?.data ??
              "An unknown error occurred. Please try again later.",
        );
      case DioExceptionType.cancel:
        return Failure(
          message: "Request was cancelled. Please try again.",
        );
      case DioExceptionType.connectionError:
        return Failure(
          message:
              "Connection error. Please check your internet connection and try again.",
        );
      case DioExceptionType.unknown:
        return Failure(
          message: "An unknown error occurred. Please try again later.",
        );
    }
  }
}
