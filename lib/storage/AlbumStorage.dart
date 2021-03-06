
import 'package:testapp/models/Album.dart';
import 'package:testapp/storage/Storage.dart';

/// Storage with Album-specific functionality
abstract class AlbumStorage extends Storage<Album>{

  /// Finds all albums with provided [userId]
  Future<List<Album>> getAlbumsByUser(int userId);
  
}