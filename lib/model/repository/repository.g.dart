// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Repository _$RepositoryFromJson(Map<String, dynamic> json) {
  return Repository(
    id: json['id'] as int,
    fullName: json['full_name'] as String,
    humanName: json['human_name'] as String,
    url: json['url'] as String,
    namespace: json['namespace'] == null
        ? null
        : Namespace.fromJson(json['namespace'] as Map<String, dynamic>),
    path: json['path'] as String,
    name: json['name'] as String,
    owner: json['owner'] == null
        ? null
        : User.fromJson(json['owner'] as Map<String, dynamic>),
    description: json['description'] as String,
    private: json['private'] as bool,
    public: json['public'] as bool,
    internal: json['internal'] as bool,
    fork: json['fork'] as bool,
    htmlUrl: json['html_url'] as String,
    sshUrl: json['ssh_url'] as String,
    recommend: json['recommend'] as bool,
    homepage: json['homepage'] as String,
    language: json['language'] as String,
    forksCount: json['forks_count'] as int,
    stargazersCount: json['stargazers_count'] as int,
    watchersCount: json['watchers_count'] as int,
    defaultBranch: json['default_branch'] as String,
    openIssuesCount: json['open_issues_count'] as int,
    hasIssues: json['has_issues'] as bool,
    hasWiki: json['has_wiki'] as bool,
    issueComment: json['issue_comment'] as bool,
    canComment: json['can_comment'] as bool,
    pullRequestsEnabled: json['pull_requests_enabled'] as bool,
    hasPages: json['has_pages'] as bool,
    license: json['license'] as String,
    outsourced: json['outsourced'] as bool,
    projectCreator: json['project_creator'] as String,
    members: (json['members'] as List)?.map((e) => e as String)?.toList(),
    pushedAt: json['pushed_at'] == null
        ? null
        : DateTime.parse(json['pushed_at'] as String),
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    stared: json['stared'] as bool,
    watched: json['watched'] as bool,
  );
}

Map<String, dynamic> _$RepositoryToJson(Repository instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'human_name': instance.humanName,
      'url': instance.url,
      'namespace': instance.namespace,
      'path': instance.path,
      'name': instance.name,
      'owner': instance.owner,
      'description': instance.description,
      'private': instance.private,
      'public': instance.public,
      'internal': instance.internal,
      'fork': instance.fork,
      'html_url': instance.htmlUrl,
      'ssh_url': instance.sshUrl,
      'recommend': instance.recommend,
      'homepage': instance.homepage,
      'language': instance.language,
      'forks_count': instance.forksCount,
      'stargazers_count': instance.stargazersCount,
      'watchers_count': instance.watchersCount,
      'default_branch': instance.defaultBranch,
      'open_issues_count': instance.openIssuesCount,
      'has_issues': instance.hasIssues,
      'has_wiki': instance.hasWiki,
      'issue_comment': instance.issueComment,
      'can_comment': instance.canComment,
      'pull_requests_enabled': instance.pullRequestsEnabled,
      'has_pages': instance.hasPages,
      'license': instance.license,
      'outsourced': instance.outsourced,
      'project_creator': instance.projectCreator,
      'members': instance.members,
      'pushed_at': instance.pushedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'stared': instance.stared,
      'watched': instance.watched,
    };
