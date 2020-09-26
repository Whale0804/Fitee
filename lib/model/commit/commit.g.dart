// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commit _$CommitFromJson(Map<String, dynamic> json) {
  return Commit(
    sha: json['sha'] as String,
    author: json['author'] == null
        ? null
        : User.fromJson(json['author'] as Map<String, dynamic>),
    message: json['message'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$CommitToJson(Commit instance) => <String, dynamic>{
      'sha': instance.sha,
      'author': instance.author,
      'message': instance.message,
      'url': instance.url,
    };
