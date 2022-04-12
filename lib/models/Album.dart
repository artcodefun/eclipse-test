import 'package:hive/hive.dart';

import 'abstract/Model.dart';
import 'abstract/Serializer.dart';

part 'Album.g.dart';

@HiveType(typeId: 5)
class Album extends Model{

  @override
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int userId;

  Album({
    required this.id,
    required this.title,
    required this.userId,
  });

  Album copyWith({
    int? id,
    String? title,
    int? userId,
  }) {
    return Album(
      id: id ?? this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
    );
  }


  @override
  List<Object?> get props =>[id, title, userId,];
}

class AlbumSerializer implements Serializer<Album> {
  @override
  Album fromMap(Map<String, dynamic> map) {
    return Album(
      id: map["id"],
      title: map["title"],
      userId: map["userId"],

    );
  }

  @override
  Map<String, dynamic> toMap(Album model) {
    return {
      "id" : model.id,
      "title" : model.title,
      "userId" : model.userId,
    };
  }
}
