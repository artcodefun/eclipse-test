
import 'package:testapp/services/Service.dart';

import '../models/Comment.dart';

abstract class CommentService extends Service<Comment>{

  /// Loads last comments with postId = [postId]
  ///
  /// first checks remote storage and then local
  Future<List<Comment>> loadLastCommentsByPost(int postId, int limit, int offset );
}