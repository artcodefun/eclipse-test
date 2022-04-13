
import 'package:testapp/models/Post.dart';
import 'package:testapp/storage/Storage.dart';

/// Storage with Post-specific functionality
abstract class PostStorage extends Storage<Post>{

  /// Finds all posts with provided [userId]
  Future<List<Post>> getPostsByUser(int userId);

}