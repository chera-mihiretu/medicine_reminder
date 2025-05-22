import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pill_reminder/cores/error/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> signIn();
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, User?>> isAuthenticated();
}
