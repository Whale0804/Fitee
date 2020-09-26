import 'package:fitee/model/payload/payload.dart';
import 'package:fitee/model/repository/repository.dart';
import 'package:fitee/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'event.g.dart';

@JsonSerializable()
class Event {
  int id;
  String type;
  User actor;
  Repository repo;
  User org;
  @JsonKey(name: "public")
  bool isPublic;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  Payload payload;

  Event({this.id, this.type, this.actor, this.repo, this.org, this.isPublic, this.createdAt});

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}

