// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subject _$SubjectFromJson(Map<String, dynamic> json) {
  return Subject(
    title: json['title'] as String,
    url: json['url'] as String,
    type: json['type'] as String,
    latestCommentUrl: json['latest_comment_url'] as String,
  );
}

Map<String, dynamic> _$SubjectToJson(Subject instance) => <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'type': instance.type,
      'latest_comment_url': instance.latestCommentUrl,
    };
