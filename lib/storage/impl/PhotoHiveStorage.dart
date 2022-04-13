import 'package:hive/hive.dart';
import 'package:testapp/models/Photo.dart';
import 'package:testapp/storage/PhotoStorage.dart';
import 'package:testapp/storage/impl/BasicHiveStorage.dart';

class PhotoHiveStorage extends BasicHiveStorage<Photo> implements PhotoStorage{
  PhotoHiveStorage(String path) : super(path, PhotoAdapter());

  @override
  Future<List<Photo>> getPhotosByAlbum(int albumId) async {
    return Hive.box<Photo>(path).values.where((p) => p.albumId==albumId).toList();
  }

}