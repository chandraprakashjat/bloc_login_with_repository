part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState(
      {this.password = const Password.pure(),
      this.name = const Name.pure(),
      this.formzStatus = FormzStatus.pure});

  final Password password;
  final Name name;
  final FormzStatus formzStatus;

  LoginState copyWith(
      {Password? password, Name? name, FormzStatus? formzStatus}) {
    return LoginState(
        password: password ?? this.password,
        name: name ?? this.name,
        formzStatus: formzStatus ?? this.formzStatus);
  }

  @override
  List<Object?> props() => [name, password, formzStatus];
}
