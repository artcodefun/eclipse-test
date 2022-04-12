import 'package:testapp/api/ApiHandler.dart';
import 'package:testapp/models/abstract/Serializer.dart';
import 'package:testapp/services/AlbumService.dart';
import 'package:testapp/services/impl/BasicService.dart';
import 'package:testapp/storage/Storage.dart';

import '../../models/Album.dart';

class AlbumServiceImpl extends BasicService<Album> implements AlbumService {
  AlbumServiceImpl(
      {required Storage<Album> storage,
        required ApiHandler apiHandler,
        required String apiPath,
        required Serializer<Album> serializer})
      : super(
      storage: storage,
      apiHandler: apiHandler,
      apiPath: apiPath,
      serializer: serializer);
}
