import 'package:hive/hive.dart';
import 'package:testapp/models/Photo.dart';
import 'package:testapp/storage/PhotoStorage.dart';
import 'package:testapp/storage/impl/BasicHiveStorage.dart';

class PhotoHiveStorage extends BasicHiveStorage<Photo> implements PhotoStorage{
  PhotoHiveStorage(String path, TypeAdapter<Photo> typeAdapter) : super(path, typeAdapter);

}