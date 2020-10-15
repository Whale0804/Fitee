import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {

  int id;
  String login;
  String name;
  // ignore: non_constant_identifier_names
  String avatar_url;
  String url;
  // ignore: non_constant_identifier_names
  String html_url;
  // ignore: non_constant_identifier_names
  String followers_url;
  // ignore: non_constant_identifier_names
  String following_url;
  // ignore: non_constant_identifier_names
  String gists_url;
  // ignore: non_constant_identifier_names
  String starred_url;
  // ignore: non_constant_identifier_names
  String subscriptions_url;
  // ignore: non_constant_identifier_names
  String organizations_url;
  // ignore: non_constant_identifier_names
  String repos_url;
  // ignore: non_constant_identifier_names
  String events_url;
  // ignore: non_constant_identifier_names
  String received_events_url;
  String type;
  String blog;
  String weibo;
  String bio;
  String company;
  // ignore: non_constant_identifier_names
  int public_repos;
  // ignore: non_constant_identifier_names
  int public_gists;
  int followers;
  int following;
  int stared;
  int watched;
  DateTime created_at;
  DateTime updated_at;
  String email;

  User({this.id,
      this.login,
      this.name,
      this.avatar_url,
      this.url,
      this.html_url,
      this.followers_url,
      this.following_url,
      this.gists_url,
      this.starred_url,
      this.subscriptions_url,
      this.organizations_url,
      this.repos_url,
      this.events_url,
      this.received_events_url,
      this.type,
      this.blog,
      this.weibo,
      this.bio,
      this.public_repos,
      this.public_gists,
      this.followers,
      this.following,
      this.stared,
      this.watched,
      this.created_at,
      this.updated_at,
      this.email});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}