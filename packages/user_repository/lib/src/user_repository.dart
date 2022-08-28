import 'package:user_repository/user_repository.dart';
import 'package:uuid/uuid.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;

    return Future.delayed(const Duration(microseconds: 1000),
        () => _user = User(id: const Uuid().v4()));
  }
}
