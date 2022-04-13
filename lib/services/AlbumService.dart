
import 'package:testapp/services/Service.dart';

import '../models/Album.dart';

abstract class AlbumService extends Service<Album>{

  /// Loads last albums by user with id = [userId]
  ///
  /// first checks remote storage and then local
  Future<List<Album>> loadLastAlbumsByUser(int userId, int limit, int offset );
  
}