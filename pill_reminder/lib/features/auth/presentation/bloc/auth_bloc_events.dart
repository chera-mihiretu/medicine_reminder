import 'package:equatable/equatable.dart';

abstract class AuthBlocEvents extends Equatable {
  const AuthBlocEvents();

  @override
  List<Object?> get props => [];
}

class AuthSignInEvent extends AuthBlocEvents {
  const AuthSignInEvent();
}

class AuthSignOutEvent extends AuthBlocEvents {
  const AuthSignOutEvent();
}

class AuthCheckEvent extends AuthBlocEvents {
  const AuthCheckEvent();
}
