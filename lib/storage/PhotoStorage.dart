
import 'package:testapp/models/Photo.dart';
import 'package:testapp/storage/Storage.dart';

/// Storage with Photo-specific functionality
abstract class PhotoStorage extends Storage<Photo>{

  /// Finds all photos with provided [albumId]
  Future<List<Photo>> getPhotosByAlbum(int albumId);
}