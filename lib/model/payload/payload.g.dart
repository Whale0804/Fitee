// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payload _$PayloadFromJson(Map<String, dynamic> json) {
  return Payload(
    action: json['action'] as String,
    ref: json['ref'] as String,
    before: json['before'] as String,
    after: json['after'] as String,
    created: json['created'] as bool,
    deleted: json['deleted'] as bool,
    size: json['size'] as int,
    commits: (json['commits'] as List)
        ?.map((e) =>
            e == null ? null : Commit.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    refType: json['ref_type'] as String,
    defaultBranch: json['default_branch'] as String,
    description: json['description'] as String,
    id: json['id'] as int,
    url: json['url'] as String,
    repositoryUrl: json['repository_url'] as String,
    commentsUrl: json['comments_url'] as String,
    htmlUrl: json['html_url'] as String,
    number: json['number'],
    state: json['state'] as String,
    title: json['title'] as String,
    body: json['body'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updateAt: json['update_at'] == null
        ? null
        : DateTime.parse(json['update_at'] as String),
    finishedAt: json['finished_at'] == null
        ? null
        : DateTime.parse(json['finished_at'] as String),
    comments: json['comments'] as int,
    issueType: json['issue_type'] as String,
    issue: json['issue'] == null
        ? null
        : Issue.fromJson(json['issue'] as Map<String, dynamic>),
    comment: json['comment'] == null
        ? null
        : Comment.fromJson(json['comment'] as Map<String, dynamic>),
    repository: json['repository'] == null
        ? null
        : Repository.fromJson(json['repository'] as Map<String, dynamic>),
    fullName: json['full_name'] as String,
    humanName: json['human_name'] as String,
    namespace: json['namespace'] == null
        ? null
        : Namespace.fromJson(json['namespace'] as Map<String, dynamic>),
    path: json['path'] as String,
    name: json['name'] as String,
    owner: json['owner'] == null
        ? null
        : User.fromJson(json['owner'] as Map<String, dynamic>),
    private: json['private'] as bool,
    public: json['public'] as bool,
    internal: json['internal'] as bool,
    fork: json['fork'] as bool,
    sshUrl: json['ssh_url'] as String,
    forksUrl: json['forks_url'] as String,
    tagsUrl: json['tags_url'] as String,
    stargazersUrl: json['stargazers_url'] as String,
    contributorsUrl: json['contributors_url'] as String,
    recommend: json['recommend'] as bool,
    homepage: json['homepage'] as String,
    forksCount: json['forks_count'] as int,
    stargazersCount: json['stargazers_count'] as int,
    watchersCount: json['watchers_count'] as int,
    openIssuesCount: json['open_issues_count'] as int,
    hasIssues: json['has_issues'] as bool,
    hasWiki: json['has_wiki'] as bool,
    issueComment: json['issue_comment'] as bool,
    canComment: json['can_comment'] as bool,
    pullRequestsEnabled: json['pull_requests_enabled'] as bool,
    hasPage: json['has_page'] as bool,
    license: json['license'] as String,
    outsourced: json['outsourced'] as bool,
    projectCreator: json['project_creator'] as String,
    members: (json['members'] as List)?.map((e) => e as String)?.toList(),
    pushedAt: json['pushed_at'] == null
        ? null
        : DateTime.parse(json['pushed_at'] as String),
    parent: json['parent'] == null
        ? null
        : Repository.fromJson(json['parent'] as Map<String, dynamic>),
    login: json['login'] as String,
    avatarUrl: json['avatar_url'] as String,
    followersUrl: json['followers_url'] as String,
    subscriptionsUrl: json['subscriptions_url'] as String,
    reposUrl: json['repos_url'] as String,
  );
}

Map<String, dynamic> _$PayloadToJson(Payload instance) => <String, dynamic>{
      'action': instance.action,
      'ref': instance.ref,
      'before': instance.before,
      'after': instance.after,
      'created': instance.created,
      'deleted': instance.deleted,
      'size': instance.size,
      'commits': instance.commits,
      'ref_type': instance.refType,
      'default_branch': instance.defaultBranch,
      'description': instance.description,
      'id': instance.id,
      'url': instance.url,
      'repository_url': instance.repositoryUrl,
      'comments_url': instance.commentsUrl,
      'html_url': instance.htmlUrl,
      'number': instance.number,
      'state': instance.state,
      'title': instance.title,
      'body': instance.body,
      'user': instance.user,
      'created_at': instance.createdAt?.toIso8601String(),
      'update_at': instance.updateAt?.toIso8601String(),
      'finished_at': instance.finishedAt?.toIso8601String(),
      'comments': instance.comments,
      'issue_type': instance.issueType,
      'issue': instance.issue,
      'comment': instance.comment,
      'repository': instance.repository,
      'full_name': instance.fullName,
      'human_name': instance.humanName,
      'namespace': instance.namespace,
      'path': instance.path,
      'name': instance.name,
      'owner': instance.owner,
      'private': instance.private,
      'public': instance.public,
      'internal': instance.internal,
      'fork': instance.fork,
      'ssh_url': instance.sshUrl,
      'forks_url': instance.forksUrl,
      'tags_url': instance.tagsUrl,
      'stargazers_url': instance.stargazersUrl,
      'contributors_url': instance.contributorsUrl,
      'recommend': instance.recommend,
      'homepage': instance.homepage,
      'forks_count': instance.forksCount,
      'stargazers_count': instance.stargazersCount,
      'watchers_count': instance.watchersCount,
      'open_issues_count': instance.openIssuesCount,
      'has_issues': instance.hasIssues,
      'has_wiki': instance.hasWiki,
      'issue_comment': instance.issueComment,
      'can_comment': instance.canComment,
      'pull_requests_enabled': instance.pullRequestsEnabled,
      'has_page': instance.hasPage,
      'license': instance.license,
      'outsourced': instance.outsourced,
      'project_creator': instance.projectCreator,
      'members': instance.members,
      'pushed_at': instance.pushedAt?.toIso8601String(),
      'parent': instance.parent,
      'login': instance.login,
      'avatar_url': instance.avatarUrl,
      'followers_url': instance.followersUrl,
      'subscriptions_url': instance.subscriptionsUrl,
      'repos_url': instance.reposUrl,
    };
