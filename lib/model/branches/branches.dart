import 'package:fitee/model/commit/commit.dart';
import 'package:fitee/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'branches.g.dart';

@JsonSerializable()
class Branches {
  String name;
  Commit commit;
  bool protected;
  @JsonKey(name:'protection_url')
  String protectionUrl;

  Branches({this.name, this.commit, this.protected, this.protectionUrl});

  factory Branches.fromJson(Map<String, dynamic> json) => _$BranchesFromJson(json);

  Map<String, dynamic> toJson() => _$BranchesToJson(this);
}