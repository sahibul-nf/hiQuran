import 'package:equatable/equatable.dart';

// class ServerException implements Exception {}

abstract class Failure extends Equatable {
  // final String message;
  // Failure(this.message);
  const Failure([List properties = const <dynamic>[]]) : super();
}

// class ServerFailure extends Failure {
//   ServerFailure(String message) : super(message);
// }

// class ConnectionFailure extends Failure {
//   ConnectionFailure(String message) : super(message);
// }

// class DatabaseFailure extends Failure {
//   DatabaseFailure(String message) : super(message);
// }
