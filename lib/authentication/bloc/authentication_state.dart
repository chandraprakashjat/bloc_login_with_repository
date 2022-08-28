part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState._(
      {this.authenticationStatus = AuthenticationStatus.unknown,
      this.user = User.empty});

  const AuthenticationState.initial() : this._();

  const AuthenticationState.authorized(User? user)
      : this._(
            user: user,
            authenticationStatus: AuthenticationStatus.authenticated);

  const AuthenticationState.unAuthorized()
      : this._(authenticationStatus: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus authenticationStatus;
  final User? user;

  @override
  List<Object?> props() => [authenticationStatus, user];
}
