// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

File _$FileFromJson(Map<String, dynamic> json) {
  return File(
    sha: json['sha'] as String,
    filename: json['filename'] as String,
    status: json['status'] as String,
    additions: json['additions'] as int,
    deletions: json['deletions'] as int,
    changes: json['changes'] as int,
    patch: json['patch'] as String,
  );
}

Map<String, dynamic> _$FileToJson(File instance) => <String, dynamic>{
      'sha': instance.sha,
      'filename': instance.filename,
      'status': instance.status,
      'additions': instance.additions,
      'deletions': instance.deletions,
      'changes': instance.changes,
      'patch': instance.patch,
    };
