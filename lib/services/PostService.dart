
import 'package:testapp/services/Service.dart';

import '../models/Post.dart';

abstract class PostService extends Service<Post>{

  /// Loads last posts by user with id = [userId]
  ///
  /// first checks remote storage and then local
  Future<List<Post>> loadLastPostsByUser(int userId, int limit, int offset );
}