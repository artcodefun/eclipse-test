import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testapp/bloc/AutoListModelCubit.dart';
import 'package:testapp/models/abstract/Model.dart';

class AutoListView<M extends Model, ALMC extends AutoListModelCubit<M>> extends StatelessWidget {
  const AutoListView({Key? key, required this.builder}) : super(key: key);

  final Widget Function(M) builder;

  @override
  Widget build(BuildContext context) {
    ALMC almc =context.watch();
    return ListView.builder(
        itemCount: almc.state.autoList.length + almc.state.offset,
        addAutomaticKeepAlives: true,
        itemBuilder: (ctx, i) {
          M m = almc.loadModelWithListAutoUpdate(i);
          return builder(m);
        }
    );
  }
}
