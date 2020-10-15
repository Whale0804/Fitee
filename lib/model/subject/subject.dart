import 'package:json_annotation/json_annotation.dart';

part 'subject.g.dart';

@JsonSerializable()
class Subject {
  String title;
  String url;
  String type;
  @JsonKey(name: 'latest_comment_url')
  String latestCommentUrl;

  Subject({this.title, this.url, this.type, this.latestCommentUrl});

  factory Subject.fromJson(Map<String, dynamic> json) => _$SubjectFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectToJson(this);
}