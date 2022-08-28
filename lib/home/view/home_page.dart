import 'package:bloc_login/authentication/bloc/authentication_bloc.dart';
import 'package:bloc_login/home/bloc/home_bloc.dart';
import 'package:bloc_login/home/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
          authenticationRepository:
              context.read<AuthenticationBloc>().authenticationRepository,
          userRepository: context.read<AuthenticationBloc>().userRepository)
        ..add(const LoadUser()),
      child: const HomeView(),
    );
  }
}
