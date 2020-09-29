// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notify_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotifyCount _$NotifyCountFromJson(Map<String, dynamic> json) {
  return NotifyCount(
    messageCount: json['message_count'] as int,
    notificationCount: json['notification_count'] as int,
    totalCount: json['total_count'] as int,
  );
}

Map<String, dynamic> _$NotifyCountToJson(NotifyCount instance) =>
    <String, dynamic>{
      'message_count': instance.messageCount,
      'notification_count': instance.notificationCount,
      'total_count': instance.totalCount,
    };
