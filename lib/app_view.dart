import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_login/authentication/bloc/authentication_bloc.dart';

import 'package:bloc_login/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/home.dart';
import 'login/login.dart';

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final navigationKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigatorState => navigationKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigationKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            print('state change ${state.authenticationStatus}');
            switch (state.authenticationStatus) {
              case AuthenticationStatus.unauthenticated:
                {
                  _navigatorState.pushAndRemoveUntil<void>(
                      LoginPage.route(), (route) => false);
                  break;
                }
              case AuthenticationStatus.authenticated:
                {
                  _navigatorState.pushAndRemoveUntil<void>(
                      SimpleHomeWidget.route(), (route) => false);
                  break;
                }

              case AuthenticationStatus.unknown:
                {
                  break;
                }
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashView.route(),
    );
  }
}
