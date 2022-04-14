import 'dart:io';

import 'package:testapp/api/ApiHandler.dart';
import 'package:testapp/models/abstract/Serializer.dart';
import 'package:testapp/services/PhotoService.dart';
import 'package:testapp/services/impl/BasicService.dart';
import 'package:testapp/storage/PhotoStorage.dart';

import '../../models/Photo.dart';

class PhotoServiceImpl extends BasicService<Photo> implements PhotoService {
  PhotoServiceImpl(
      {required this.storage,
        required ApiHandler apiHandler,
        required String apiPath,
        required this.albumApiPath,
        required String Function(int) photoFilePathResolver,
        required Serializer<Photo> serializer})
      : super(
      storage: storage,
      apiHandler: apiHandler,
      apiPath: apiPath,
      serializer: serializer,
  preSave: (p)async{
    ()async{
      try{
        if(! await File(photoFilePathResolver(p.id)).exists()) {
          await apiHandler.download(p.url, photoFilePathResolver(p.id));
        }
      }finally{}
    }();

        return p;});

  final String albumApiPath;

  @override
  PhotoStorage storage;

  @override
  Future<List<Photo>> loadLastPhotosByAlbum(int albumId, int limit, int offset ) async {
    List<Photo> albums;
    try {
      albums = await apiHandler.get(albumApiPath + "$albumId/" + apiPath,
          {"_sort": "id", "_order": "desc", "_limit": limit, "_start": offset}, listConverter);

      for (int i = 0; i < albums.length; i++) {
        albums[i] = await save(albums[i]);
      }
    } catch (e) {
      albums = await storage.getPhotosByAlbum(albumId);
      albums.sort((a, b) => b.id.compareTo(a.id));
      albums= albums.skip(offset).take(limit).toList();
    }
    return albums;
  }
}
