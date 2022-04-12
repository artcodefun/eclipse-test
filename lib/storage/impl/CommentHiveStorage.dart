import 'package:hive/hive.dart';
import 'package:testapp/models/Comment.dart';
import 'package:testapp/storage/CommentStorage.dart';
import 'package:testapp/storage/impl/BasicHiveStorage.dart';

class CommentHiveStorage extends BasicHiveStorage<Comment> implements CommentStorage{
  CommentHiveStorage(String path, TypeAdapter<Comment> typeAdapter) : super(path, typeAdapter);

}