import 'package:fitee/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'issue.g.dart';

@JsonSerializable()
class Issue {
  int id;
  String url;
  @JsonKey(name: "repository_url")
  String repositoryUrl;
  @JsonKey(name: "comments_url")
  String commentsUrl;
  @JsonKey(name: "html_url")
  String htmlUrl;
  String number;
  String state;
  String title;
  String body;
  User user;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "update_at")
  DateTime updateAt;
  @JsonKey(name: "finished_at")
  DateTime finishedAt;
  int comments;
  @JsonKey(name: "issue_type")
  String issueType;

  Issue({this.id, this.url, this.repositoryUrl, this.commentsUrl, this.htmlUrl,
    this.number, this.state, this.title, this.body, this.user, this.createdAt, this.updateAt,
    this.finishedAt, this.comments, this.issueType
  });

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);

  Map<String, dynamic> toJson() => _$IssueToJson(this);
}