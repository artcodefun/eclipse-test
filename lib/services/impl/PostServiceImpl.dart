import 'package:testapp/api/ApiHandler.dart';
import 'package:testapp/models/abstract/Serializer.dart';
import 'package:testapp/services/PostService.dart';
import 'package:testapp/services/impl/BasicService.dart';
import 'package:testapp/storage/PostStorage.dart';

import '../../models/Post.dart';

class PostServiceImpl extends BasicService<Post> implements PostService {
  PostServiceImpl(
      {required PostStorage storage,
        required ApiHandler apiHandler,
        required String apiPath,
        required Serializer<Post> serializer})
      : super(
      storage: storage,
      apiHandler: apiHandler,
      apiPath: apiPath,
      serializer: serializer);
}
