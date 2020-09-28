import 'package:fitee/model/comment/comment.dart';
import 'package:fitee/model/commit/commit.dart';
import 'package:fitee/model/issue/issue.dart';
import 'package:fitee/model/namespace/namespace.dart';
import 'package:fitee/model/repository/repository.dart';
import 'package:fitee/model/user/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payload.g.dart';

@JsonSerializable()
class Payload {
  String action;
  String ref;

  // push event
  String before;
  String after;
  bool created;
  bool deleted;
  int size;
  List<Commit> commits;

  // create event
  @JsonKey(name: "ref_type")
  String refType;
  @JsonKey(name: "default_branch")
  String defaultBranch;
  String description;

  // issue event
  int id;
  String url;
  @JsonKey(name: "repository_url")
  String repositoryUrl;
  @JsonKey(name: "comments_url")
  String commentsUrl;
  @JsonKey(name: "html_url")
  String htmlUrl;
  dynamic number;
  String state;
  String title;
  String body;
  User user;
  @JsonKey(name: "created_at")
  DateTime createdAt;
  @JsonKey(name: "update_at")
  DateTime updateAt;
  @JsonKey(name: "finished_at")
  DateTime finishedAt;
  int comments;
  @JsonKey(name: "issue_type")
  String issueType;

  // Issue Comment Event
  Issue issue;
  Comment comment;
  Repository repository;

  // Fork Event
  @JsonKey(name: "full_name")
  String fullName;
  @JsonKey(name: "human_name")
  String humanName;
  Namespace namespace;
  String path;
  String name;
  User owner;
  bool private;
  bool public;
  bool internal;
  bool fork;
  @JsonKey(name: "ssh_url")
  String sshUrl;
  @JsonKey(name: "forks_url")
  String forksUrl;
  @JsonKey(name: "tags_url")
  String tagsUrl;
  @JsonKey(name: "stargazers_url")
  String stargazersUrl;
  @JsonKey(name: "contributors_url")
  String contributorsUrl;
  bool recommend;
  String homepage;
  @JsonKey(name: "forks_count")
  int forksCount;
  @JsonKey(name: "stargazers_count")
  int stargazersCount;
  @JsonKey(name: "watchers_count")
  int watchersCount;
  @JsonKey(name: "open_issues_count")
  int openIssuesCount;
  @JsonKey(name: "has_issues")
  bool hasIssues;
  @JsonKey(name: "has_wiki")
  bool hasWiki;
  @JsonKey(name: "issue_comment")
  bool issueComment;
  @JsonKey(name: "can_comment")
  bool canComment;
  @JsonKey(name: "pull_requests_enabled")
  bool pullRequestsEnabled;
  @JsonKey(name: "has_page")
  bool hasPage;
  String license;
  bool outsourced;
  @JsonKey(name: "project_creator")
  String projectCreator;
  List<String> members;
  @JsonKey(name: "pushed_at")
  DateTime pushedAt;
  Repository parent;

  //Project Comment Event

  // Member Event
  String login;
  @JsonKey(name: "avatar_url")
  String avatarUrl;
  @JsonKey(name: "followers_url")
  String followersUrl;
  @JsonKey(name: "subscriptions_url")
  String subscriptionsUrl;
  @JsonKey(name: "repos_url")
  String reposUrl;

  Payload({
      this.action,
      this.ref,
      this.before,
      this.after,
      this.created,
      this.deleted,
      this.size,
      this.commits,
      this.refType,
      this.defaultBranch,
      this.description,
      this.id,
      this.url,
      this.repositoryUrl,
      this.commentsUrl,
      this.htmlUrl,
      this.number,
      this.state,
      this.title,
      this.body,
      this.user,
      this.createdAt,
      this.updateAt,
      this.finishedAt,
      this.comments,
      this.issueType,
      this.issue,
      this.comment,
      this.repository,
      this.fullName,
      this.humanName,
      this.namespace,
      this.path,
      this.name,
      this.owner,
      this.private,
      this.public,
      this.internal,
      this.fork,
      this.sshUrl,
      this.forksUrl,
      this.tagsUrl,
      this.stargazersUrl,
      this.contributorsUrl,
      this.recommend,
      this.homepage,
      this.forksCount,
      this.stargazersCount,
      this.watchersCount,
      this.openIssuesCount,
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
      this.parent,
      this.login,
      this.avatarUrl,
      this.followersUrl,
      this.subscriptionsUrl,
      this.reposUrl});

  factory Payload.fromJson(Map<String, dynamic> json) => _$PayloadFromJson(json);

  Map<String, dynamic> toJson() => _$PayloadToJson(this);
}