import 'package:hive/hive.dart';
import 'package:testapp/models/Post.dart';
import 'package:testapp/storage/PostStorage.dart';
import 'package:testapp/storage/impl/BasicHiveStorage.dart';

class PostHiveStorage extends BasicHiveStorage<Post> implements PostStorage{
  PostHiveStorage(String path, TypeAdapter<Post> typeAdapter) : super(path, typeAdapter);

}