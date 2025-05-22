import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBlocStates extends Equatable {
  const AuthBlocStates();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthBlocStates {
  const AuthInitialState();
}

class AuthLoadingState extends AuthBlocStates {
  const AuthLoadingState();
}

class AuthSignedInState extends AuthBlocStates {
  final UserCredential? user;
  const AuthSignedInState({required this.user});
}

class CurrentUserState extends AuthBlocStates {
  final User? user;
  const CurrentUserState({required this.user});
}

class AuthSignedOutState extends AuthBlocStates {
  const AuthSignedOutState();
}

class AuthErrorState extends AuthBlocStates {
  final String message;

  const AuthErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
