import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_login/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloc Login'),
      ),
      body: BlocProvider(
        create: (_) => LoginBloc(
            authenticationRepository: context.read<AuthenticationRepository>()),
        child: const LoginForm(),
      ),
    );
  }
}
