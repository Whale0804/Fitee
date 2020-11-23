// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_tree.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileTree _$FileTreeFromJson(Map<String, dynamic> json) {
  return FileTree(
    path: json['path'] as String,
    mode: json['mode'] as String,
    type: json['type'] as String,
    sha: json['sha'] as String,
    size: json['size'] as int,
    url: json['url'] as String,
  )..name = json['name'] as String;
}

Map<String, dynamic> _$FileTreeToJson(FileTree instance) => <String, dynamic>{
      'path': instance.path,
      'mode': instance.mode,
      'type': instance.type,
      'sha': instance.sha,
      'size': instance.size,
      'url': instance.url,
      'name': instance.name,
    };
