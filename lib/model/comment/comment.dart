import 'package:fitee/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'comment.g.dart';

@JsonSerializable()
class Comment {
  int id;
  String url;
  @JsonKey(name: "html_url")
  String htmlUrl;
  @JsonKey(name: "issue_url")
  String issueUrl;
  User user;
  String body;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "update_at")
  DateTime updateAt;


  Comment({this.id, this.url, this.htmlUrl, this.issueUrl, this.user, this.body, this.createdAt, this.updateAt});

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}