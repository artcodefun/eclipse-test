import 'package:testapp/api/ApiHandler.dart';
import 'package:testapp/models/abstract/Serializer.dart';
import 'package:testapp/services/CommentService.dart';
import 'package:testapp/services/impl/BasicService.dart';
import 'package:testapp/storage/CommentStorage.dart';

import '../../models/Comment.dart';

class CommentServiceImpl extends BasicService<Comment> implements CommentService {
  CommentServiceImpl(
      {required this.storage,
        required ApiHandler apiHandler,
        required String apiPath,
        required this.postApiPath,
        required Serializer<Comment> serializer})
      : super(
      storage: storage,
      apiHandler: apiHandler,
      apiPath: apiPath,
      serializer: serializer);

  final String postApiPath;

  @override
  CommentStorage storage;

  @override
  Future<List<Comment>> loadLastCommentsByPost(int postId, int limit, int offset ) async {
    List<Comment> posts;
    try {
      posts = await apiHandler.get(postApiPath + "$postId/" + apiPath,
          {"_sort": "id", "_order": "asc", "_limit": limit, "_start": offset}, listConverter);

      for (int i = 0; i < posts.length; i++) {
        posts[i] = await save(posts[i]);
      }
    } catch (e) {
      posts = await storage.getCommentsByPost(postId);
      posts.sort((a, b) => a.id.compareTo(b.id));
      posts= posts.skip(offset).take(limit).toList();
    }
    return posts;
  }
}
