import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({this.key = AppError.serverError, this.message, this.status});

  final AppError key;
  final String? message;
  final int? status;

  @override
  List<Object?> get props => [key, message, status];
}

class ServerFailure extends Failure {
  const ServerFailure([String? message = 'Server connection error', int? status])
      : super(message: message, status: status);
}

class CacheFailure extends Failure {
  const CacheFailure(String? message, [int? status])
      : super(message: message, status: status);
}

enum AppError { serverError, jsonParsing }
