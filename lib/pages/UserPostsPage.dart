import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:testapp/bloc/AutoListModelState.dart';
import 'package:testapp/bloc/post/UserPostListCubit.dart';
import 'package:testapp/components/PostListItem.dart';
import '../components/AutoListView.dart';
import '../models/Post.dart';

class UserPostsPage extends StatelessWidget {
  const UserPostsPage({Key? key, required this.userId, this.appBarColor}) : super(key: key);

  final int userId;
  final Color? appBarColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Posts"), backgroundColor:  appBarColor,),
        body: BlocProvider(
            create: (BuildContext context) {
              return UserPostListCubit(
                  service: Provider.of<Injector>(context, listen: false).get(),
                  userId: userId)
                ..loadLast();
            },
            child: BlocBuilder<UserPostListCubit, AutoListModelState<Post>>(
              builder: (ctx, state) =>
                  state.status == AutoListModelStateStatus.active
                      ? AutoListView<Post, UserPostListCubit>(builder: (Post p)=>PostListItem(post: p))
                      : const Center(child: CircularProgressIndicator()),
              buildWhen: (s1, s2) => s1.status != s2.status,
            )));
  }
}
