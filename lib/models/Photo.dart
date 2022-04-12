import 'package:hive/hive.dart';

import 'abstract/Model.dart';
import 'abstract/Serializer.dart';

part 'Photo.g.dart';

@HiveType(typeId: 6)
class Photo extends Model{

  @override
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int albumId;
  @HiveField(3)
  final String url;
  @HiveField(4)
  final String thumbnailUrl;



  @override
  List<Object?> get props =>[id, title, albumId, url, thumbnailUrl];

   Photo({
    required this.id,
    required this.title,
    required this.albumId,
    required this.url,
    required this.thumbnailUrl,
  });

  Photo copyWith({
    int? id,
    String? title,
    int? albumId,
    String? url,
    String? thumbnailUrl,
  }) {
    return Photo(
      id: id ?? this.id,
      title: title ?? this.title,
      albumId: albumId ?? this.albumId,
      url: url ?? this.url,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }
}

class PhotoSerializer implements Serializer<Photo> {
  @override
  Photo fromMap(Map<String, dynamic> map) {
    return Photo(
      id: map['id'],
      title: map['title'],
      albumId: map['albumId'],
      url: map['url'],
      thumbnailUrl: map['thumbnailUrl'],
    );
  }

  @override
  Map<String, dynamic> toMap(Photo model) {
    return {
      'id': model.id,
      'title': model.title,
      'albumId': model.albumId,
      'url': model.url,
      'thumbnailUrl': model.thumbnailUrl,
    };
  }
}
