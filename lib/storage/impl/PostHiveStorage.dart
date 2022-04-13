import 'package:hive/hive.dart';
import 'package:testapp/models/Post.dart';
import 'package:testapp/storage/PostStorage.dart';
import 'package:testapp/storage/impl/BasicHiveStorage.dart';

class PostHiveStorage extends BasicHiveStorage<Post> implements PostStorage{
  PostHiveStorage(String path) : super(path, PostAdapter());

  @override
  Future<List<Post>> getPostsByUser(int userId) async{
    return Hive.box<Post>(path).values.where((p) => p.userId==userId).toList();
  }

}