import 'package:testapp/bloc/AutoListModelCubit.dart';
import 'package:testapp/models/Album.dart';
import 'package:testapp/services/AlbumService.dart';

import '../AutoListModelState.dart';

class UserAlbumListCubit extends AutoListModelCubit<Album> {
  UserAlbumListCubit({required this.service, required this.userId})
      : super(service: service);

  @override
  final AlbumService service;

  final int userId;

  @override
  loadLast() async {
    emit(state.copyWith(status: AutoListModelStateStatus.loading));
    var models = await service.loadLastAlbumsByUser(userId, settings.size, 0);
    models.sort((a, b) => b.id.compareTo(a.id));
    emit(AutoListModelState(
        status: AutoListModelStateStatus.active,
        autoList: models,
        offset: 0,
        canLoadNewer: false,
        canLoadOlder: models.length == settings.size));
  }

  @override
  Future loadNewer(int amount) async {
    emit(state.copyWith(status: AutoListModelStateStatus.loading));
    List<Album> newerModels = await service.loadLastAlbumsByUser(userId, amount,
        (state.offset - amount).clamp(0, double.maxFinite.toInt()));

    if (newerModels.isEmpty) {
      emit(state.copyWith(canLoadNewer: false));
      return;
    }

    newerModels.sort((a, b) => b.id.compareTo(a.id));

    List<Album> models = newerModels +
        state.autoList.take(settings.size - newerModels.length).toList();

    emit(state.copyWith(
        status: AutoListModelStateStatus.active,
        autoList: models,
        offset: state.offset - newerModels.length,
        canLoadOlder: true,
        canLoadNewer: true));
  }

  @override
  Future loadOlder(int amount) async{
    emit(state.copyWith(status: AutoListModelStateStatus.loading));
    List<Album> olderModels = await service.loadLastAlbumsByUser(userId, amount,
        state.offset + state.autoList.length);


    if (olderModels.isEmpty) {
      emit(state.copyWith(canLoadOlder: false));
      return;
    }

    olderModels.sort((a, b) => b.id.compareTo(a.id));

    List<Album> models =
        state.autoList.skip(olderModels.length).toList() + olderModels;

    emit(state.copyWith(
        status: AutoListModelStateStatus.active,
        autoList: models,
        offset: state.offset + olderModels.length,
        canLoadOlder: true,
        canLoadNewer: true));
  }
}
