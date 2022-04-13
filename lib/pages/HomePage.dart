import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:testapp/bloc/AutoListModelState.dart';
import 'package:testapp/bloc/user/UserListCubit.dart';
import 'package:testapp/components/AutoListView.dart';
import 'package:testapp/components/UserListItem.dart';

import '../bloc/user/UserCubit.dart';
import '../models/User.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (BuildContext context) {
              return UserListCubit(
                  service: Provider.of<Injector>(context, listen: false).get())
                ..loadLast();
            },
            child: BlocBuilder<UserListCubit, AutoListModelState<User>>(
              builder: (ctx, state) =>
                  state.status == AutoListModelStateStatus.active
                      ? AutoListView<User, UserListCubit>(builder: (User u)=>UserListItem(user: u))
                      : const Center(child: CircularProgressIndicator()),
              buildWhen: (s1, s2) => s1.status != s2.status,
            )));
  }
}
