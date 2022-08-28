import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;
  final AuthenticationRepository authenticationRepository;
  StreamSubscription<AuthenticationStatus>? authStreamSubscription;
  AuthenticationBloc(
      {required this.authenticationRepository, required this.userRepository})
      : super(const AuthenticationState.initial()) {
    on<UserAuthenticationChange>(_onUserAuthenticationChange);
    on<UserLogoutEvent>(_onUserLogout);

    authStreamSubscription =
        authenticationRepository.authStatus.listen((authenticationStatus) {
      add(UserAuthenticationChange(authenticationStatus: authenticationStatus));
    });
  }

  FutureOr<void> _onUserAuthenticationChange(
      UserAuthenticationChange event, Emitter<AuthenticationState> emit) async {
    switch (event.authenticationStatus) {
      case AuthenticationStatus.unknown:
        {
          emit(const AuthenticationState.initial());
          break;
        }
      case AuthenticationStatus.authenticated:
        {
          final user = await _getUser();

          emit(user != null
              ? AuthenticationState.authorized(user)
              : const AuthenticationState.unAuthorized());

          break;
        }

      case AuthenticationStatus.unauthenticated:
        {
          emit(const AuthenticationState.unAuthorized());
          break;
        }
    }
  }

  FutureOr<void> _onUserLogout(
      UserLogoutEvent event, Emitter<AuthenticationState> emit) {
    authenticationRepository.logout();
  }

  Future<User?> _getUser() async {
    try {
      final user = await userRepository.getUser();
      return user;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<void> close() {
    authenticationRepository.dispose();
    authStreamSubscription?.cancel();
    return super.close();
  }
}
