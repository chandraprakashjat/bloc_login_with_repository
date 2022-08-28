import 'package:bloc_login/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadFailed extends StatelessWidget {
  const LoadFailed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(
          Icons.error,
          color: Colors.red,
          size: 100,
        ),
        const Padding(
          padding: EdgeInsets.all(30),
          child:
              Text('Please try again to load user detail. Press Reload button'),
        ),
        TextButton(
            onPressed: () => context.read<HomeBloc>().add(const LoadUser()),
            child: const Text('Reload'))
      ]),
    );
  }
}
