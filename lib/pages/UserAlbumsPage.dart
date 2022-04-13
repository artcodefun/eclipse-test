import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:testapp/bloc/AutoListModelState.dart';
import 'package:testapp/components/AlbumListItem.dart';
import '../bloc/album/UserAlbumListCubit.dart';
import '../components/AutoListView.dart';
import '../models/Album.dart';

class UserAlbumsPage extends StatelessWidget {
  const UserAlbumsPage({Key? key, required this.userId, this.appBarColor}) : super(key: key);

  final int userId;
  final Color? appBarColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Albums"), backgroundColor:  appBarColor,),
        body: BlocProvider(
            create: (BuildContext context) {
              return UserAlbumListCubit(
                  service: Provider.of<Injector>(context, listen: false).get(),
                  userId: userId)
                ..loadLast();
            },
            child: BlocBuilder<UserAlbumListCubit, AutoListModelState<Album>>(
              builder: (ctx, state) =>
              state.status == AutoListModelStateStatus.active
                  ? AutoListView<Album, UserAlbumListCubit>(builder: (Album a)=>AlbumListItem(album: a))
                  : const Center(child: CircularProgressIndicator()),
              buildWhen: (s1, s2) => s1.status != s2.status,
            )));
  }
}
