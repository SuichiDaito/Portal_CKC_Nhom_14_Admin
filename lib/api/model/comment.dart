import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Comment {
  final String userName;
  final String content;
  final String timestamp;

  Comment({
    required this.userName,
    required this.content,
    required this.timestamp,
  });
}

//   // factory Comment.fromJson(Map<String, dynamic> json) {
//   //   return Comment(
//   //     postId: json['postId'],
//   //     id: json['id'],
//   //     name: json['name'],
//   //     email: json['email'],
//   //     body: json['body'],
//   //   );
//   // }
// }
