import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class CreateUserException implements Exception {
  String message;
  Exception exception;

  CreateUserException(this.message, {this.exception});

  @override
  String toString() {
    return 'CreateUserException{message: $message, exception: $exception}';
  }

}


class ConnectionError extends DioError {
  
}