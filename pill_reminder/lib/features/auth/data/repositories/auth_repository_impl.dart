import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pill_reminder/cores/error/failure.dart';
import 'package:pill_reminder/features/auth/data/data_source/auth_data_source.dart';
import 'package:pill_reminder/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  AuthRepositoryImpl({required this.authDataSource});
  @override
  Future<Either<Failure, UserCredential>> signIn() async {
    try {
      UserCredential userCredential = await authDataSource.signIn();
      return Right(userCredential);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await authDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User?>> isAuthenticated() async {
    try {
      User? user = await authDataSource.isAuthenticated();
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
