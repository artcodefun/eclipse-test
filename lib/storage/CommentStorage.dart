
import 'package:testapp/models/Comment.dart';
import 'package:testapp/storage/Storage.dart';

/// Storage with Comment-specific functionality
abstract class CommentStorage extends Storage<Comment>{

  /// Finds all comments with provided [postId]
  Future<List<Comment>> getCommentsByPost(int postId);

}