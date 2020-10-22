// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'readme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Readme _$ReadmeFromJson(Map<String, dynamic> json) {
  return Readme(
    type: json['type'] as String,
    encoding: json['encoding'] as String,
    size: json['size'] as int,
    name: json['name'] as String,
    path: json['path'] as String,
    content: json['content'] as String,
    sha: json['sha'] as String,
    url: json['url'] as String,
    downloadUrl: json['download_url'] as String,
    htmlUrl: json['html_url'] as String,
  );
}

Map<String, dynamic> _$ReadmeToJson(Readme instance) => <String, dynamic>{
      'type': instance.type,
      'encoding': instance.encoding,
      'size': instance.size,
      'name': instance.name,
      'path': instance.path,
      'content': instance.content,
      'sha': instance.sha,
      'url': instance.url,
      'html_url': instance.htmlUrl,
      'download_url': instance.downloadUrl,
    };
