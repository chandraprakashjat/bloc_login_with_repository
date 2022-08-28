import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_login/app_view.dart';
import 'package:bloc_login/authentication/authenticate.dart';
import 'package:bloc_login/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key,
      required this.userRepository,
      required this.authenticationRepository});

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider<AuthenticationBloc>(
        create: (_) => AuthenticationBloc(
            authenticationRepository: authenticationRepository,
            userRepository: userRepository),
        child: const AppView(),
      ),
    );
  }
}
