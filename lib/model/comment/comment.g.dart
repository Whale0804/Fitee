// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    id: json['id'] as int,
    url: json['url'] as String,
    htmlUrl: json['html_url'] as String,
    issueUrl: json['issue_url'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    body: json['body'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updateAt: json['update_at'] == null
        ? null
        : DateTime.parse(json['update_at'] as String),
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'html_url': instance.htmlUrl,
      'issue_url': instance.issueUrl,
      'user': instance.user,
      'body': instance.body,
      'created_at': instance.createdAt?.toIso8601String(),
      'update_at': instance.updateAt?.toIso8601String(),
    };
