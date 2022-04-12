import 'package:hive/hive.dart';

import 'abstract/Model.dart';
import 'abstract/Serializer.dart';

part 'Post.g.dart';

@HiveType(typeId: 3)
class Post extends Model{

  @override
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int userId;
  @HiveField(3)
  final String body;

  Post({
    required this.id,
    required this.title,
    required this.userId,
    required this.body,
  });

  Post copyWith({
    int? id,
    String? title,
    int? userId,
    String? body,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      userId: userId ?? this.userId,
      body: body ?? this.body,
    );
  }


  @override
  List<Object?> get props =>[id, title, userId, body];
}

class PostSerializer implements Serializer<Post> {
  @override
  Post fromMap(Map<String, dynamic> map) {
    return Post(
      id: map["id"],
      title: map["title"],
      userId: map["userId"],
      body: map["body"],
    );
  }

  @override
  Map<String, dynamic> toMap(Post model) {
    return {
      "id" : model.id,
      "title" : model.title,
      "userId" : model.userId,
      "body" : model.body,
    };
  }
}
