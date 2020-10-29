import 'package:fitee/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'release.g.dart';

@JsonSerializable()
class Release {

  int id;
  @JsonKey(name: "tag_name")
  String tagName;
  @JsonKey(name: "target_commitish")
  String targetCommitish;
  bool prerelease;
  String name;
  String body;
  User author;
  @JsonKey(name: 'created_at')
  DateTime createdAt;

  Release({this.id, this.tagName, this.targetCommitish, this.prerelease, this.name, this.body, this.createdAt});

  factory Release.fromJson(Map<String, dynamic> json) => _$ReleaseFromJson(json);

  Map<String, dynamic> toJson() => _$ReleaseToJson(this);
}