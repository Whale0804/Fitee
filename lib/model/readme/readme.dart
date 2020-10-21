import 'package:fitee/model/user/user.dart';

import 'package:json_annotation/json_annotation.dart';

part 'readme.g.dart';

@JsonSerializable()
class Readme {

  String type;
  String encoding;
  int size;
  String name;
  String path;
  String content;
  String sha;
  String url;
  @JsonKey(name: 'html_url')
  String htmlUrl;
  @JsonKey(name: 'download_url')
  String downloadUrl;
}