import 'package:testapp/api/ApiHandler.dart';
import 'package:testapp/models/abstract/Serializer.dart';
import 'package:testapp/services/AlbumService.dart';
import 'package:testapp/services/impl/BasicService.dart';
import 'package:testapp/storage/AlbumStorage.dart';

import '../../models/Album.dart';

class AlbumServiceImpl extends BasicService<Album> implements AlbumService {
  AlbumServiceImpl(
      {required this.storage,
        required ApiHandler apiHandler,
        required String apiPath,
        required this.userApiPath,
        required Serializer<Album> serializer})
      : super(
      storage: storage,
      apiHandler: apiHandler,
      apiPath: apiPath,
      serializer: serializer);

  final String userApiPath;

  @override
  AlbumStorage storage;

  @override
  Future<List<Album>> loadLastAlbumsByUser(int userId, int limit, offset) async {
    List<Album> albums;
    try {
      albums = await apiHandler.get(userApiPath + "$userId/" + apiPath,
          {"_sort": "id", "_order": "desc", "_limit": limit, "_start": offset}, listConverter);

      for (int i = 0; i < albums.length; i++) {
        albums[i] = await save(albums[i]);
      }
    } catch (e) {
      albums = await storage.getAlbumsByUser(userId);
      albums.sort((a, b) => b.id.compareTo(a.id));
      albums= albums.skip(offset).take(limit).toList();
    }
    return albums;
  }
}
