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
        return ServerFailure(errormessage: ' BadCertificate with ApiServer');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response!.statusCode!,
          dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(errormessage: 'Request to ApiServer was cancel');
      case DioExceptionType.connectionError:
        return ServerFailure(errormessage: 'Check your internet connection');
      case DioExceptionType.unknown:
        return ServerFailure(
          errormessage: 'Oops There was an error, Please try Again',
        );
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic reponse) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(errormessage: reponse['error']['info']);
    } else if (statusCode == 404) {
      return ServerFailure(
        errormessage: 'Your request is not found, Please try Again',
      );
    } else if (statusCode == 505) {
      return ServerFailure(errormessage: reponse['error']['info']);
    } else {
      return ServerFailure(
        errormessage: 'Oops There was an error, Please try Again',
      );
    }
  }
}
