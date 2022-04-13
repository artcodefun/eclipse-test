import 'package:testapp/bloc/SingleModelCubit.dart';
import 'package:testapp/bloc/SingleModelState.dart';
import 'package:testapp/services/AlbumService.dart';

import '../../models/Album.dart';

class AlbumCubit extends SingleModelCubit<Album> {
  AlbumCubit({
    required AlbumService service,
    Album? album,
  }) : super(
      initial: SingleModelState(
          status: album == null
              ? SingleModelStateStatus.created
              : SingleModelStateStatus.active,
          model: album),
      service: service);
}
