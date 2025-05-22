import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/auth/domain/repositories/auth_repository.dart';

class AuthStateUsecase {
  final AuthRepository authRepository;

  AuthStateUsecase(this.authRepository);

  Future<Either<Failure, User?>> call() async {
    return await authRepository.isAuthenticated();
  }
}
