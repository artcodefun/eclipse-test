import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'package:testapp/bloc/SingleModelState.dart';
import 'package:testapp/bloc/user/UserCubit.dart';
import 'package:testapp/models/Album.dart';

import '../bloc/AutoListModelState.dart';
import '../bloc/album/AlbumCubit.dart';
import '../bloc/photo/AlbumPhotoListCubit.dart';
import '../components/HalfFixedScrollView.dart';
import '../components/PhotoListItem.dart';
import '../models/Photo.dart';
import '../models/User.dart';
import '../utils/color.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({Key? key, required this.albumId, this.appBarColor})
      : super(key: key);

  final int albumId;
  final Color? appBarColor;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => AlbumCubit(
              service: Provider.of<Injector>(context, listen: false).get())
            ..loadModel(albumId),
        ),
        BlocProvider(
          create: (ctx) => AlbumPhotoListCubit(
              service: Provider.of<Injector>(context, listen: false).get(),
              albumId: albumId)
            ..loadLast(),
        ),
      ],
      child: BlocBuilder<AlbumCubit, SingleModelState<Album>>(
        builder: (ctx, albumState) {
          AlbumSerializer us = AlbumSerializer();
          bool active = albumState.status == SingleModelStateStatus.active;
          Widget body = !active
              ? const Center(child: CircularProgressIndicator())
              : BlocBuilder<AlbumPhotoListCubit, AutoListModelState<Photo>>(
            builder: (ctx, photoState) {
              bool active =
                  photoState.status == AutoListModelStateStatus.active;
              AlbumPhotoListCubit aplc = ctx.read();
              return HalfFixedScrollView(
                fixedPart: [
                  for (var v in us.toMap(albumState.model!).entries)
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
                      "Photos :",
                      style: theme.textTheme.headline5,
                    ),
                  ),
                ],
                builder: (ctx, i) => PhotoListItem(
                    photo: aplc.loadModelWithListAutoUpdate(i)),
                buildChildrenCount:
                photoState.autoList.length + photoState.offset,
                footerPart: [
                  if (active)
                    const SizedBox(
                      height: 100,
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    )
                ],
              );
            },
          );
          return Scaffold(
              appBar: AppBar(
                backgroundColor: appBarColor,
                title: Text(albumState.model?.id.toString() ?? ""),
              ),
              body: body);
        },
      ),
    );
  }
}


/*
SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var v in us.toMap(state.model!).entries)
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
                    "Photos :",
                    style: theme.textTheme.headline5,
                  ),
                ),
                BlocBuilder<AlbumPhotoListCubit,
                    AutoListModelState<Photo>>(
                  builder: (ctx, state) =>
                  state.status == AutoListModelStateStatus.active
                      ? const PhotoListView()
                      : const CircularProgressIndicator(),
                  buildWhen: (s1, s2) => s1.status != s2.status,
                ),
              ],
            ),
          );
*/
