import 'dart:math';

import 'package:flutter/material.dart';
import 'package:testapp/pages/UserPage.dart';

import '../models/User.dart';
import '../utils/color.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => UserPage(
                userId: user.id,
                appBarColor: randColor(Random(user.id)),
              ))),
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(0, 5),
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(25),
            color: randColor(Random(user.id))),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 200,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            user.username,
            style: theme.textTheme.headline4?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600),
          ),
          Text(
            user.name,
            style: theme.textTheme.headline5?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w600),
          )
        ]),
      ),
    );
  }
}
