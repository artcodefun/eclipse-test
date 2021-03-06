
import 'package:hive/hive.dart';
import 'package:testapp/models/Album.dart';
import 'package:testapp/storage/AlbumStorage.dart';
import 'package:testapp/storage/impl/BasicHiveStorage.dart';

class AlbumHiveStorage extends BasicHiveStorage<Album> implements AlbumStorage{
  AlbumHiveStorage(String path) : super(path, AlbumAdapter());

  @override
  Future<List<Album>> getAlbumsByUser(int userId) async{
    return Hive.box<Album>(path).values.where((p) => p.userId==userId).toList();
  }
}