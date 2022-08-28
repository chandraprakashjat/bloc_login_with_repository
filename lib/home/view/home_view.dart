import 'package:bloc_login/home/bloc/home_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/widget_home.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home View'),
          actions: [
            IconButton(
                onPressed: () => context.read<HomeBloc>().add(LogoutUser()),
                icon: const Icon(Icons.logout))
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          switch (state.homeStatus) {
            case HomeStatus.initial:
              return const LoadingWidget();

            case HomeStatus.success:
              return UserDetail(user: state.user);

            case HomeStatus.failed:
              return const LoadFailed();
          }
        }));
  }
}
