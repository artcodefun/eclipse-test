import 'package:hive/hive.dart';

import 'abstract/Model.dart';
import 'abstract/Serializer.dart';

part 'Comment.g.dart';

@HiveType(typeId: 4)
class Comment extends Model {
  Comment({
    required this.id,
    required this.postId,
    required this.name,
    required this.body,
    required this.email,
  });

  @override
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int postId;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String body;
  @HiveField(4)
  final String email;

  @override
  List<Object?> get props => [id, postId, name, body, email];

  Comment copyWith({
    int? id,
    int? postId,
    String? name,
    String? body,
    String? email,
  }) {
    return Comment(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      name: name ?? this.name,
      body: body ?? this.body,
      email: email ?? this.email,
    );
  }
}

class CommentSerializer implements Serializer<Comment> {
  @override
  Comment fromMap(Map<String, dynamic> map) {
    return Comment(
        id: map["id"],
        body: map["body"],
        postId: map["postId"],
        email: map["email"],
        name: map["name"]);
  }

  @override
  Map<String, dynamic> toMap(Comment model) {
    return {
      "id": model.id,
      "postId": model.postId,
      "name": model.name,
      "body": model.body,
      "email": model.email,
    };
  }
}
