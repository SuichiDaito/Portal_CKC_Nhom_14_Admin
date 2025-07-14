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
