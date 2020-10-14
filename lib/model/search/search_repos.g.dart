// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_repos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchRepos _$SearchReposFromJson(Map<String, dynamic> json) {
  return SearchRepos(
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
    forksUrl: json['forks_url'] as String,
    stargazersUrl: json['stargazers_url'] as String,
    contributorsUrl: json['contributors_url'] as String,
    recommend: json['recommend'] as bool,
    homepage: json['homepage'] as String,
    language: json['language'] as String,
    forksCount: json['forks_count'] as int,
    stargazersCount: json['stargazers_count'] as int,
    watchersCount: json['watchers_count'] as int,
    openIssuesCount: json['open_issues_count'] as int,
    defaultBranch: json['default_branch'] as String,
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
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    assigneesNumber: json['assignees_number'] as int,
    testersNumber: json['testers_number'] as int,
    assignees: (json['assignees'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    testers: (json['testers'] as List)
        ?.map(
            (e) => e == null ? null : User.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SearchReposToJson(SearchRepos instance) =>
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
      'forks_url': instance.forksUrl,
      'stargazers_url': instance.stargazersUrl,
      'contributors_url': instance.contributorsUrl,
      'recommend': instance.recommend,
      'homepage': instance.homepage,
      'language': instance.language,
      'forks_count': instance.forksCount,
      'stargazers_count': instance.stargazersCount,
      'watchers_count': instance.watchersCount,
      'open_issues_count': instance.openIssuesCount,
      'default_branch': instance.defaultBranch,
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
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'assignees_number': instance.assigneesNumber,
      'testers_number': instance.testersNumber,
      'assignees': instance.assignees,
      'testers': instance.testers,
    };
