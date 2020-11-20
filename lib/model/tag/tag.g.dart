// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag(
    name: json['name'] as String,
    message: json['message'] as String,
    commit: json['commit'] == null
        ? null
        : Commit.fromJson(json['commit'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'name': instance.name,
      'message': instance.message,
      'commit': instance.commit,
    };
