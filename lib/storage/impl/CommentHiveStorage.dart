import 'package:hive/hive.dart';
import 'package:testapp/models/Comment.dart';
import 'package:testapp/storage/CommentStorage.dart';
import 'package:testapp/storage/impl/BasicHiveStorage.dart';

class CommentHiveStorage extends BasicHiveStorage<Comment> implements CommentStorage{
  CommentHiveStorage(String path) : super(path, CommentAdapter());

  @override
  Future<List<Comment>> getCommentsByPost(int postId) async {
    return Hive.box<Comment>(path).values.where((c) => c.postId==postId).toList();
  }

}