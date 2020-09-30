import 'package:fitee/model/namespace/namespace.dart';
import 'package:fitee/model/repository/repository.dart';
import 'package:fitee/model/subject/subject.dart';
import 'package:fitee/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notify.g.dart';

@JsonSerializable()
class Notify {
  int id;
  String content;
  String type;
  bool unread;
  bool mute;
  String url;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  @JsonKey(name: 'html_url')
  String htmlUrl;

  User actor;
  Repository repository;
  Subject subject;
  List<Namespace> namespaces;

  Notify({this.id, this.content, this.type, this.unread, this.mute, this.url,
    this.updatedAt,this.htmlUrl, this.subject, this.repository, this.actor, this.namespaces});

  factory Notify.fromJson(Map<String, dynamic> json) => _$NotifyFromJson(json);

  Map<String, dynamic> toJson() => _$NotifyToJson(this);
}