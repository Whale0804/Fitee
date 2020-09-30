// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'letter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Letter _$LetterFromJson(Map<String, dynamic> json) {
  return Letter(
    id: json['id'] as int,
    unread: json['unread'] as bool,
    content: json['content'] as String,
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    url: json['url'] as String,
    htmlUrl: json['html_url'] as String,
    sender: json['sender'] == null
        ? null
        : User.fromJson(json['sender'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LetterToJson(Letter instance) => <String, dynamic>{
      'id': instance.id,
      'unread': instance.unread,
      'content': instance.content,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'url': instance.url,
      'html_url': instance.htmlUrl,
      'sender': instance.sender,
    };
