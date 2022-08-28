import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

class UserDetail extends StatelessWidget {
  const UserDetail({Key? key, required this.user}) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Load User is : ${user.id}',
            style: theme.bodyText1,
          )
        ],
      ),
    );
  }
}
