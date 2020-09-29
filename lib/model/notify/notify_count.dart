import 'package:json_annotation/json_annotation.dart';
part 'notify_count.g.dart';

@JsonSerializable()
class NotifyCount {
  @JsonKey(name: 'message_count')
  int messageCount;
  @JsonKey(name:'notification_count')
  int notificationCount;
  @JsonKey(name: 'total_count')
  int totalCount;

  NotifyCount({this.messageCount, this.notificationCount, this.totalCount});

  factory NotifyCount.fromJson(Map<String, dynamic> json) => _$NotifyCountFromJson(json);

  Map<String, dynamic> toJson() => _$NotifyCountToJson(this);
}