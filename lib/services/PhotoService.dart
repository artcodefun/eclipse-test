
import 'package:testapp/services/Service.dart';

import '../models/Photo.dart';

abstract class PhotoService extends Service<Photo>{
  /// Loads last photos with albumId = [albumId]
  ///
  /// first checks remote storage and then local
  Future<List<Photo>> loadLastPhotosByAlbum(int albumId, int limit, int offset );
}