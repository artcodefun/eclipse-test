import 'package:testapp/bloc/AutoListModelCubit.dart';
import 'package:testapp/models/Photo.dart';
import 'package:testapp/services/PhotoService.dart';

import '../AutoListModelState.dart';

class AlbumPhotoListCubit extends AutoListModelCubit<Photo> {
  AlbumPhotoListCubit({required this.service, required this.albumId})
      : super(service: service);

  @override
  final PhotoService service;

  final int albumId;

  @override
  loadLast() async {
    emit(state.copyWith(status: AutoListModelStateStatus.loading));
    var models = await service.loadLastPhotosByAlbum(albumId, settings.size, 0);
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
    List<Photo> newerModels = await service.loadLastPhotosByAlbum(albumId, amount,
        (state.offset - amount).clamp(0, double.maxFinite.toInt()));

    if (newerModels.isEmpty) {
      emit(state.copyWith(status: AutoListModelStateStatus.active, canLoadNewer: false));
      return;
    }

    newerModels.sort((a, b) => b.id.compareTo(a.id));

    List<Photo> models = newerModels +
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
    List<Photo> olderModels = await service.loadLastPhotosByAlbum(albumId, amount,
        state.offset + state.autoList.length);


    if (olderModels.isEmpty) {
      emit(state.copyWith(status: AutoListModelStateStatus.active, canLoadOlder: false));
      return;
    }

    olderModels.sort((a, b) => b.id.compareTo(a.id));

    List<Photo> models =
        state.autoList.skip(olderModels.length).toList() + olderModels;

    emit(state.copyWith(
        status: AutoListModelStateStatus.active,
        autoList: models,
        offset: state.offset + olderModels.length,
        canLoadOlder: true,
        canLoadNewer: true));
  }
}
