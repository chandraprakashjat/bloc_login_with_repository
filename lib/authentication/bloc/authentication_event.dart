part of 'authentication_bloc.dart';

class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object?> props() => [];
}

class UserAuthenticationChange extends AuthenticationEvent {
  const UserAuthenticationChange({required this.authenticationStatus});
  final AuthenticationStatus authenticationStatus;

  @override
  List<Object?> props() => [authenticationStatus];
}

class UserLogoutEvent extends AuthenticationEvent {}
