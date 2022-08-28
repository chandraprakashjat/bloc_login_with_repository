part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> props() => [];
}

class NameChangeEvent extends LoginEvent {
  final String userName;
  const NameChangeEvent(this.userName);
  @override
  List<Object?> props() => [userName];
}

class PasswordChangeEvent extends LoginEvent {
  final String password;

  const PasswordChangeEvent(this.password);
  @override
  List<Object?> props() => [password];
}

class OnSubmit extends LoginEvent {}

class UnFocusName extends LoginEvent {}

class UnFocusPassword extends LoginEvent {}
