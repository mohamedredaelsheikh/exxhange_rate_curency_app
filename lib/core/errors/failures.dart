import 'package:dio/dio.dart';

abstract class Failure {
  final String errormessage;

  Failure({required this.errormessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errormessage});

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errormessage: 'Connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errormessage: 'Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errormessage: 'Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure(errormessage: 'Bad certificate with ApiServer');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response!.statusCode!,
          dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          errormessage: 'Request to ApiServer was cancelled',
        );
      case DioExceptionType.connectionError:
        return ServerFailure(errormessage: 'Check your internet connection');
      case DioExceptionType.unknown:
        return ServerFailure(
          errormessage: 'Oops, there was an error. Please try again',
        );
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(
        errormessage: response['error']?['info'] ?? 'Invalid request',
      );
    } else if (statusCode == 404) {
      return ServerFailure(
        errormessage: 'Your request was not found. Please try again',
      );
    } else if (statusCode == 505) {
      return ServerFailure(
        errormessage: response['error']?['info'] ?? 'Internal server error',
      );
    } else {
      return ServerFailure(
        errormessage: 'Oops, there was an error. Please try again',
      );
    }
  }
}
