import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_reminder/features/auth/domain/usecases/auth_state_usecase.dart';
import 'package:pill_reminder/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:pill_reminder/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:pill_reminder/features/auth/presentation/bloc/auth_bloc_events.dart';
import 'package:pill_reminder/features/auth/presentation/bloc/auth_bloc_states.dart';

class AuthBloc extends Bloc<AuthBlocEvents, AuthBlocStates> {
  final SignInUsecase signInUsecase;
  final AuthStateUsecase authStateUsecase;
  final SignOutUsecase signOutUsecase;
  AuthBloc({
    required this.signInUsecase,
    required this.authStateUsecase,
    required this.signOutUsecase,
  }) : super(const AuthInitialState()) {
    on<AuthSignInEvent>((event, emit) async {
      emit(const AuthLoadingState());
      final result = await signInUsecase.call();

      result.fold((failure) {
        emit(AuthErrorState(message: failure.message));
      }, (user) => emit(AuthSignedInState(user: user)));
    });
    on<AuthSignOutEvent>((event, emit) async {
      final result = await signOutUsecase.call();

      result.fold(
        (failure) {
          emit(AuthErrorState(message: failure.message));
        },
        (success) {
          emit(const AuthSignedOutState());
        },
      );
    });
    on<AuthCheckEvent>((event, emit) async {
      final result = await authStateUsecase.call();

      result.fold(
        (failure) {
          emit(const CurrentUserState(user: null));
        },
        (user) {
          emit(CurrentUserState(user: user));
        },
      );
    });
  }
}
