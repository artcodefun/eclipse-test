import 'package:testapp/api/ApiHandler.dart';
import 'package:testapp/models/abstract/Serializer.dart';
import 'package:testapp/services/PhotoService.dart';
import 'package:testapp/services/impl/BasicService.dart';
import 'package:testapp/storage/PhotoStorage.dart';

import '../../models/Photo.dart';

class PhotoServiceImpl extends BasicService<Photo> implements PhotoService {
  PhotoServiceImpl(
      {required PhotoStorage storage,
        required ApiHandler apiHandler,
        required String apiPath,
        required Serializer<Photo> serializer})
      : super(
      storage: storage,
      apiHandler: apiHandler,
      apiPath: apiPath,
      serializer: serializer);
}
