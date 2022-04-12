import 'package:testapp/api/ApiHandler.dart';
import 'package:testapp/models/abstract/Serializer.dart';
import 'package:testapp/services/CommentService.dart';
import 'package:testapp/services/impl/BasicService.dart';
import 'package:testapp/storage/Storage.dart';

import '../../models/Comment.dart';

class CommentServiceImpl extends BasicService<Comment> implements CommentService {
  CommentServiceImpl(
      {required Storage<Comment> storage,
        required ApiHandler apiHandler,
        required String apiPath,
        required Serializer<Comment> serializer})
      : super(
      storage: storage,
      apiHandler: apiHandler,
      apiPath: apiPath,
      serializer: serializer);
}
