import 'package:fitee/model/namespace/namespace.dart';
import 'package:fitee/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_repos.g.dart';

@JsonSerializable()
class SearchRepos {

  int id;
  @JsonKey(name: "full_name")
  String fullName;
  @JsonKey(name: 'human_name')
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
  @JsonKey(name: 'html_url')
  String htmlUrl;
  @JsonKey(name: 'ssh_url')
  String sshUrl;
  @JsonKey(name: 'forks_url')
  String forksUrl;
  @JsonKey(name: 'stargazers_url')
  String stargazersUrl;
  @JsonKey(name: 'contributors_url')
  String contributorsUrl;
  bool recommend;
  String homepage;
  String language;
  @JsonKey(name: 'forks_count')
  int forksCount;
  @JsonKey(name: 'stargazers_count')
  int stargazersCount;
  @JsonKey(name: 'watchers_count')
  int watchersCount;
  @JsonKey(name: 'open_issues_count')
  int openIssuesCount;
  @JsonKey(name: 'default_branch')
  String defaultBranch;
  @JsonKey(name: 'has_issues')
  bool hasIssues;
  @JsonKey(name: 'has_wiki')
  bool hasWiki;
  @JsonKey(name: 'issue_comment')
  bool issueComment;
  @JsonKey(name: 'can_comment')
  bool canComment;
  @JsonKey(name: 'pull_requests_enabled')
  bool pullRequestsEnabled;
  @JsonKey(name: 'has_page')
  bool hasPage;
  String license;
  bool outsourced;
  @JsonKey(name: 'project_creator')
  String projectCreator;
  List<String> members;
  @JsonKey(name: 'pushed_at')
  DateTime pushedAt;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  @JsonKey(name: 'assignees_number')
  int assigneesNumber;
  @JsonKey(name: 'testers_number')
  int testersNumber;
  List<User> assignees;
  List<User> testers;


  SearchRepos({
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
    this.forksUrl,
    this.stargazersUrl,
    this.contributorsUrl,
    this.recommend,
    this.homepage,
    this.language,
    this.forksCount,
    this.stargazersCount,
    this.watchersCount,
    this.openIssuesCount,
    this.defaultBranch,
    this.hasIssues,
    this.hasWiki,
    this.issueComment,
    this.canComment,
    this.pullRequestsEnabled,
    this.hasPage,
    this.license,
    this.outsourced,
    this.projectCreator,
    this.members,
    this.pushedAt,
    this.createdAt,
    this.updatedAt,
    this.assigneesNumber,
    this.testersNumber,
    this.assignees,
    this.testers,
  });


  factory SearchRepos.fromJson(Map<String, dynamic> json) => _$SearchReposFromJson(json);

  Map<String, dynamic> toJson() => _$SearchReposToJson(this);
}