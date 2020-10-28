// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stats _$StatsFromJson(Map<String, dynamic> json) {
  return Stats(
    id: json['id'] as String,
    additions: json['additions'] as int,
    deletions: json['deletions'] as int,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$StatsToJson(Stats instance) => <String, dynamic>{
      'id': instance.id,
      'additions': instance.additions,
      'deletions': instance.deletions,
      'total': instance.total,
    };
