// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
    id: json['id'] as int,
    type: json['type'] as String,
    actor: json['actor'] == null
        ? null
        : User.fromJson(json['actor'] as Map<String, dynamic>),
    repo: json['repo'] == null
        ? null
        : Repository.fromJson(json['repo'] as Map<String, dynamic>),
    org: json['org'] == null
        ? null
        : User.fromJson(json['org'] as Map<String, dynamic>),
    isPublic: json['public'] as bool,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  )..payload = json['payload'] == null
      ? null
      : Payload.fromJson(json['payload'] as Map<String, dynamic>);
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'actor': instance.actor,
      'repo': instance.repo,
      'org': instance.org,
      'public': instance.isPublic,
      'created_at': instance.createdAt?.toIso8601String(),
      'payload': instance.payload,
    };
