import 'package:json_annotation/json_annotation.dart';

part 'namespace.g.dart';

@JsonSerializable()
class Namespace {

  int id;
  String type;
  String path;

  @JsonKey(name: "html_url")
  String htmlUrl;

  Namespace({this.id, this.type, this.path, this.htmlUrl});

  factory Namespace.fromJson(Map<String, dynamic> json) => _$NamespaceFromJson(json);

  Map<String, dynamic> toJson() => _$NamespaceToJson(this);
}