import 'package:dartz/dartz.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/auth/domain/repositories/auth_repository.dart';

class SignOutUsecase {
  final AuthRepository authRepository;

  SignOutUsecase(this.authRepository);

  Future<Either<Failure, void>> call() async {
    return await authRepository.signOut();
  }
}
