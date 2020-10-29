// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'release.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Release _$ReleaseFromJson(Map<String, dynamic> json) {
  return Release(
    id: json['id'] as int,
    tagName: json['tag_name'] as String,
    targetCommitish: json['target_commitish'] as String,
    prerelease: json['prerelease'] as bool,
    name: json['name'] as String,
    body: json['body'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  )..author = json['author'] == null
      ? null
      : User.fromJson(json['author'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ReleaseToJson(Release instance) => <String, dynamic>{
      'id': instance.id,
      'tag_name': instance.tagName,
      'target_commitish': instance.targetCommitish,
      'prerelease': instance.prerelease,
      'name': instance.name,
      'body': instance.body,
      'author': instance.author,
      'created_at': instance.createdAt?.toIso8601String(),
    };
