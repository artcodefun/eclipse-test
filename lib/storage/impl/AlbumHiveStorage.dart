
import 'package:hive/hive.dart';
import 'package:testapp/models/Album.dart';
import 'package:testapp/storage/AlbumStorage.dart';
import 'package:testapp/storage/impl/BasicHiveStorage.dart';

class AlbumHiveStorage extends BasicHiveStorage<Album> implements AlbumStorage{
  AlbumHiveStorage(String path, TypeAdapter<Album> typeAdapter) : super(path, typeAdapter);

}