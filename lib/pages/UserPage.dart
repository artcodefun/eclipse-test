import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:testapp/bloc/AutoListModelState.dart';
import 'package:testapp/bloc/SingleModelState.dart';
import 'package:testapp/bloc/post/UserPostListCubit.dart';
import 'package:testapp/bloc/user/UserCubit.dart';
import 'package:testapp/components/PostListItem.dart';
import 'package:testapp/pages/UserPostsPage.dart';

import '../bloc/album/UserAlbumListCubit.dart';
import '../components/AlbumListItem.dart';
import '../models/Album.dart';
import '../models/Post.dart';
import '../models/User.dart';
import '../utils/color.dart';
import 'UserAlbumsPage.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key, required this.userId, this.appBarColor})
      : super(key: key);

  final int userId;
  final Color? appBarColor;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => UserCubit(
              service: Provider.of<Injector>(context, listen: false).get())
            ..loadModel(userId),
        ),
        BlocProvider(
          create: (ctx) => UserPostListCubit(
              service: Provider.of<Injector>(context, listen: false).get(),
              userId: userId)
            ..loadLast(),
        ),
        BlocProvider(
          create: (ctx) => UserAlbumListCubit(
              service: Provider.of<Injector>(context, listen: false).get(),
              userId: userId)
            ..loadLast(),
        ),
      ],
      child: BlocBuilder<UserCubit, SingleModelState<User>>(
        builder: (ctx, userState) {
          UserSerializer us = UserSerializer();
          bool active = userState.status == SingleModelStateStatus.active;
          Widget body = !active
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var v in us.toMap(userState.model!).entries)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                v.key + " : ",
                                style: theme.textTheme.headline6,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: Text(
                                "${v.value}",
                                style: theme.textTheme.headline6,
                              ))
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Recent Posts :",
                          style: theme.textTheme.headline5,
                        ),
                      ),
                      BlocBuilder<UserPostListCubit, AutoListModelState<Post>>(
                        builder: (ctx, postsState) => postsState.status ==
                                AutoListModelStateStatus.active
                            ? GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (ctx) => UserPostsPage(
                                              userId: userState.model!.id,
                                          appBarColor: appBarColor,
                                            ))),
                                child: Container(
                                  color: Colors.transparent,
                                  child: IgnorePointer(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        for (int i = 0;
                                            i <
                                                min(3,
                                                    postsState.autoList.length);
                                            i++)
                                          PostListItem(
                                              post: postsState.autoList[i])
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : const Center(child: CircularProgressIndicator()),
                        buildWhen: (s1, s2) => s1.status != s2.status,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Recent Albums :",
                          style: theme.textTheme.headline5,
                        ),
                      ),
                      BlocBuilder<UserAlbumListCubit, AutoListModelState<Album>>(
                        builder: (ctx, albumsState) => albumsState.status ==
                            AutoListModelStateStatus.active
                            ? GestureDetector(
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(
                              builder: (ctx) => UserAlbumsPage(
                                userId: userState.model!.id,
                                appBarColor: appBarColor,
                              ))),
                          child: Container(
                            color: Colors.transparent,
                            child: IgnorePointer(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                                children: [
                                  for (int i = 0;
                                  i <
                                      min(3,
                                          albumsState.autoList.length);
                                  i++)
                                    AlbumListItem(
                                        album: albumsState.autoList[i])
                                ],
                              ),
                            ),
                          ),
                        )
                            : const Center(child: CircularProgressIndicator()),
                        buildWhen: (s1, s2) => s1.status != s2.status,
                      )
                    ],
                  ),
                );
          return Scaffold(
              appBar: AppBar(
                backgroundColor: appBarColor,
                title: Text(userState.model?.username ?? ""),
              ),
              body: body);
        },
      ),
    );
  }
}
