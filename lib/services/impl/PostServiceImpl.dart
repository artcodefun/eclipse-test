import 'package:testapp/api/ApiHandler.dart';
import 'package:testapp/models/abstract/Serializer.dart';
import 'package:testapp/services/PostService.dart';
import 'package:testapp/services/impl/BasicService.dart';
import 'package:testapp/storage/PostStorage.dart';

import '../../models/Post.dart';

class PostServiceImpl extends BasicService<Post> implements PostService {
  PostServiceImpl(
      {required this.storage,
      required ApiHandler apiHandler,
      required String apiPath,
      required this.userApiPath,
      required Serializer<Post> serializer})
      : super(
            storage: storage,
            apiHandler: apiHandler,
            apiPath: apiPath,
            serializer: serializer);

  final String userApiPath;

  @override
  PostStorage storage;

  @override
  Future<List<Post>> loadLastPostsByUser(int userId, int limit, offset) async {
    List<Post> posts;
    try {
      posts = await apiHandler.get(userApiPath + "$userId/" + apiPath,
          {"_sort": "id", "_order": "desc", "_limit": limit, "_start": offset}, listConverter);

      for (int i = 0; i < posts.length; i++) {
        posts[i] = await save(posts[i]);
      }
    } catch (e) {
      posts = await storage.getPostsByUser(userId);
      posts.sort((a, b) => b.id.compareTo(a.id));
      posts= posts.skip(offset).take(limit).toList();
    }
    return posts;
  }
}
