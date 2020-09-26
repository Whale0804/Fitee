import 'package:fitee/model/user/user.dart';

import 'package:json_annotation/json_annotation.dart';

part 'commit.g.dart';

@JsonSerializable()
class Commit {
  String sha;
  User author;
  String message;
  String url;

  Commit({this.sha, this.author, this.message, this.url});

  factory Commit.fromJson(Map<String, dynamic> json) => _$CommitFromJson(json);

  Map<String, dynamic> toJson() => _$CommitToJson(this);
}