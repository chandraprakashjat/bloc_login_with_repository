import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_login/app_observer.dart';
import 'package:bloc_login/my_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  runApp(MyApp(
    userRepository: UserRepository(),
    authenticationRepository: AuthenticationRepository(),
  ));
}
