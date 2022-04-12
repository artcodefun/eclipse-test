import 'package:hive/hive.dart';
import 'package:testapp/models/User.dart';
import 'package:testapp/storage/UserStorage.dart';
import 'package:testapp/storage/impl/BasicHiveStorage.dart';

class UserHiveStorage extends BasicHiveStorage<User> implements UserStorage{
  UserHiveStorage(String path, TypeAdapter<User> typeAdapter) : super(path, typeAdapter);

}