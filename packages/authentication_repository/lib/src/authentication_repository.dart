import 'dart:async';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _streamController = StreamController<AuthenticationStatus>();
  String? userId;

  Stream<AuthenticationStatus> get authStatus async* {
    await Future.delayed(const Duration(milliseconds: 200));

    yield AuthenticationStatus.unauthenticated;

    yield* _streamController.stream;
  }

  Future<void> login(
      {required String userName, required String password}) async {
    Future.delayed(const Duration(microseconds: 400),
        () => _streamController.add(AuthenticationStatus.authenticated));

    userId = userName;
  }

  void logout() {
    _streamController.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _streamController.close();

  String getUserId() => userId!;
}
