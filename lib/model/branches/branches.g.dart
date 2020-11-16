// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branches.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Branches _$BranchesFromJson(Map<String, dynamic> json) {
  return Branches(
    name: json['name'] as String,
    commit: json['commit'] == null
        ? null
        : Commit.fromJson(json['commit'] as Map<String, dynamic>),
    protected: json['protected'] as bool,
    protectionUrl: json['protection_url'] as String,
  );
}

Map<String, dynamic> _$BranchesToJson(Branches instance) => <String, dynamic>{
      'name': instance.name,
      'commit': instance.commit,
      'protected': instance.protected,
      'protection_url': instance.protectionUrl,
    };
