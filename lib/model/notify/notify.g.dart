// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notify _$NotifyFromJson(Map<String, dynamic> json) {
  return Notify(
    id: json['id'] as int,
    content: json['content'] as String,
    type: json['type'] as String,
    unread: json['unread'] as bool,
    mute: json['mute'] as bool,
    url: json['url'] as String,
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    htmlUrl: json['html_url'] as String,
    subject: json['subject'] == null
        ? null
        : Subject.fromJson(json['subject'] as Map<String, dynamic>),
    repository: json['repository'] == null
        ? null
        : Repository.fromJson(json['repository'] as Map<String, dynamic>),
    actor: json['actor'] == null
        ? null
        : User.fromJson(json['actor'] as Map<String, dynamic>),
    namespaces: (json['namespaces'] as List)
        ?.map((e) =>
            e == null ? null : Namespace.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$NotifyToJson(Notify instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'type': instance.type,
      'unread': instance.unread,
      'mute': instance.mute,
      'url': instance.url,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'html_url': instance.htmlUrl,
      'actor': instance.actor,
      'repository': instance.repository,
      'subject': instance.subject,
      'namespaces': instance.namespaces,
    };
