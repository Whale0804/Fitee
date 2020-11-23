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
    files: (json['files'] as List)
        ?.map((e) =>
            e == null ? null : FileCommit.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  )
    ..committer = json['committer'] == null
        ? null
        : User.fromJson(json['committer'] as Map<String, dynamic>)
    ..commit = json['commit'] == null
        ? null
        : Commit.fromJson(json['commit'] as Map<String, dynamic>)
    ..stats = json['stats'] == null
        ? null
        : Stats.fromJson(json['stats'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CommitToJson(Commit instance) => <String, dynamic>{
      'sha': instance.sha,
      'message': instance.message,
      'url': instance.url,
      'author': instance.author,
      'committer': instance.committer,
      'commit': instance.commit,
      'stats': instance.stats,
      'files': instance.files,
      'date': instance.date?.toIso8601String(),
    };
