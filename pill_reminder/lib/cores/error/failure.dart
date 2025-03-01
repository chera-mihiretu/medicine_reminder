import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  @override
  // ignore: overridden_fields
  final String message;

  const CacheFailure({
    required this.message,
  }) : super(message);
}

class PermissionFailure extends Failure {
  @override
  // ignore: overridden_fields
  final String message;
  const PermissionFailure({required this.message}) : super(message);
}
