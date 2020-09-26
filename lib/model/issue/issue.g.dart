// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Issue _$IssueFromJson(Map<String, dynamic> json) {
  return Issue(
    id: json['id'] as int,
    url: json['url'] as String,
    repositoryUrl: json['repository_url'] as String,
    commentsUrl: json['comments_url'] as String,
    htmlUrl: json['html_url'] as String,
    number: json['number'] as String,
    state: json['state'] as String,
    title: json['title'] as String,
    body: json['body'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updateAt: json['update_at'] == null
        ? null
        : DateTime.parse(json['update_at'] as String),
    finishedAt: json['finished_at'] == null
        ? null
        : DateTime.parse(json['finished_at'] as String),
    comments: json['comments'] as int,
    issueType: json['issue_type'] as String,
  );
}

Map<String, dynamic> _$IssueToJson(Issue instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'repository_url': instance.repositoryUrl,
      'comments_url': instance.commentsUrl,
      'html_url': instance.htmlUrl,
      'number': instance.number,
      'state': instance.state,
      'title': instance.title,
      'body': instance.body,
      'user': instance.user,
      'created_at': instance.createdAt?.toIso8601String(),
      'update_at': instance.updateAt?.toIso8601String(),
      'finished_at': instance.finishedAt?.toIso8601String(),
      'comments': instance.comments,
      'issue_type': instance.issueType,
    };
