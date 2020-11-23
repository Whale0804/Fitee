import 'package:json_annotation/json_annotation.dart';

part 'file_entity.g.dart';

@JsonSerializable()
class FileEntity {
  String sha;
  int size;
  String url;
  String content;
  String encoding;

  FileEntity({this.sha, this.size, this.url, this.content, this.encoding});

  factory FileEntity.fromJson(Map<String, dynamic> json) => _$FileEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FileEntityToJson(this);
}