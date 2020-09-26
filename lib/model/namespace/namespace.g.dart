// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'namespace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Namespace _$NamespaceFromJson(Map<String, dynamic> json) {
  return Namespace(
    id: json['id'] as int,
    type: json['type'] as String,
    path: json['path'] as String,
    htmlUrl: json['html_url'] as String,
  );
}

Map<String, dynamic> _$NamespaceToJson(Namespace instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'path': instance.path,
      'html_url': instance.htmlUrl,
    };
