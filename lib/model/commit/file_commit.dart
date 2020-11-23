import 'package:json_annotation/json_annotation.dart';

part 'file_commit.g.dart';

@JsonSerializable()
class FileCommit {
  String sha;
  String filename;
  String status;
  int additions;
  int deletions;
  int changes;
  String patch;

  FileCommit({this.sha, this.filename, this.status, this.additions, this.deletions, this.changes, this.patch});

  factory FileCommit.fromJson(Map<String, dynamic> json) => _$FileCommitFromJson(json);

  Map<String, dynamic> toJson() => _$FileCommitToJson(this);
}