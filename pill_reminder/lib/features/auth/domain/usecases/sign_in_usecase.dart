import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/auth/domain/repositories/auth_repository.dart';

class SignInUsecase {
  final AuthRepository authRepository;

  SignInUsecase(this.authRepository);

  Future<Either<Failure, UserCredential>> call() async {
    return await authRepository.signIn();
  }
}
