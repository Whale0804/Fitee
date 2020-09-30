import 'package:fitee/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'letter.g.dart';

@JsonSerializable()
class Letter {
  int id;
  bool unread;
  String content;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  String url;
  @JsonKey(name: 'html_url')
  String htmlUrl;
  User sender;

  Letter({this.id, this.unread, this.content, this.updatedAt, this.url, this.htmlUrl, this.sender});

  factory Letter.fromJson(Map<String, dynamic> json) => _$LetterFromJson(json);

  Map<String, dynamic> toJson() => _$LetterToJson(this);
}