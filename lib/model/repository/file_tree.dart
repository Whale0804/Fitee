import 'package:json_annotation/json_annotation.dart';

part 'file_tree.g.dart';

@JsonSerializable()
class FileTree {

  String path;
  String mode;
  String type;
  String sha;
  int size;
  String url;

  FileTree({this.path, this.mode, this.type, this.sha, this.size, this.url});

  factory FileTree.fromJson(Map<String, dynamic> json) => _$FileTreeFromJson(json);

  Map<String, dynamic> toJson() => _$FileTreeToJson(this);
}