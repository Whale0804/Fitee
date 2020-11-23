// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileEntity _$FileEntityFromJson(Map<String, dynamic> json) {
  return FileEntity(
    sha: json['sha'] as String,
    size: json['size'] as int,
    url: json['url'] as String,
    content: json['content'] as String,
    encoding: json['encoding'] as String,
  );
}

Map<String, dynamic> _$FileEntityToJson(FileEntity instance) =>
    <String, dynamic>{
      'sha': instance.sha,
      'size': instance.size,
      'url': instance.url,
      'content': instance.content,
      'encoding': instance.encoding,
    };
