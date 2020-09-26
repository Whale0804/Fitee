import 'package:fitee/model/namespace/namespace.dart';
import 'package:fitee/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repository.g.dart';

@JsonSerializable()
class Repository {

  int id;
  @JsonKey(name: "full_name")
  String fullName;
  @JsonKey(name: "human_name")
  String humanName;
  String url;
  Namespace namespace;
  String path;
  String name;
  User owner;
  String description;
  bool private;
  bool public;
  bool internal;
  bool fork;
  @JsonKey(name: "html_url")
  String htmlUrl;
  @JsonKey(name: "ssh_url")
  String sshUrl;
  bool recommend;
  String homepage;
  String language;
  @JsonKey(name: "forks_count")
  int forksCount;
  @JsonKey(name: "stargazers_count")
  int stargazersCount;
  @JsonKey(name: "watchers_count")
  int watchersCount;
  @JsonKey(name: "default_branch")
  String defaultBranch;
  @JsonKey(name: "open_issues_count")
  int openIssuesCount;
  @JsonKey(name: 'has_issues')
  bool hasIssues;
  @JsonKey(name: 'has_wiki')
  bool hasWiki;
  @JsonKey(name: "issue_comment")
  bool issueComment;
  @JsonKey(name: "can_comment")
  bool canComment;
  @JsonKey(name: "pull_requests_enabled")
  bool pullRequestsEnabled;
  @JsonKey(name: "has_pages")
  bool hasPages;
  String license;
  bool outsourced;
  @JsonKey(name: "project_creator")
  String projectCreator;
  List<String> members;
  @JsonKey(name: "pushed_at")
  DateTime pushedAt;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "updated_at")
  DateTime updatedAt;
  bool stared;
  bool watched;

  Repository({
    this.id,
    this.fullName,
    this.humanName,
    this.url,
    this.namespace,
    this.path,
    this.name,
    this.owner,
    this.description,
    this.private,
    this.public,
    this.internal,
    this.fork,
    this.htmlUrl,
    this.sshUrl,
    this.recommend,
    this.homepage,
    this.language,
    this.forksCount,
    this.stargazersCount,
    this.watchersCount,
    this.defaultBranch,
    this.openIssuesCount,
    this.hasIssues,
    this.hasWiki,
    this.issueComment,
    this.canComment,
    this.pullRequestsEnabled,
    this.hasPages,
    this.license,
    this.outsourced,
    this.projectCreator,
    this.members,
    this.pushedAt,
    this.createdAt,
    this.updatedAt,
    this.stared,
    this.watched
  });

  factory Repository.fromJson(Map<String, dynamic> json) => _$RepositoryFromJson(json);

  Map<String, dynamic> toJson() => _$RepositoryToJson(this);

}