import 'package:bloc_login/authentication/bloc/authentication_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleHomeWidget extends StatelessWidget {
  const SimpleHomeWidget({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SimpleHomeWidget());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
              onPressed: () =>
                  context.read<AuthenticationBloc>().add(UserLogoutEvent()),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
          child: Column(
        children: [
          Builder(builder: (context) {
            final id = context
                .select((AuthenticationBloc bloc) => bloc.state.user?.id);
            return Text('User Id : $id');
          })
        ],
      )),
    );
  }
}
