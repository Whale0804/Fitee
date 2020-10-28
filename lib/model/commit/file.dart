import 'package:json_annotation/json_annotation.dart';

part 'file.g.dart';

@JsonSerializable()
class File {
  String sha;
  String filename;
  String status;
  int additions;
  int deletions;
  int changes;
  String patch;

  File({this.sha, this.filename, this.status, this.additions, this.deletions, this.changes, this.patch});

  factory File.fromJson(Map<String, dynamic> json) => _$FileFromJson(json);

  Map<String, dynamic> toJson() => _$FileToJson(this);
}