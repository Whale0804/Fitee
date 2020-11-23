
import 'package:fitee/model/readme/readme.dart';
import 'package:fitee/model/repository/file_entity.dart';
import 'package:fitee/model/repository/file_tree.dart';
import 'package:fitee/model/repository/repository.dart';
import 'package:fitee/model/user/user.dart';
import 'package:fitee/plugin/request/request.dart';
import 'package:flutter/material.dart';

class ReposApi {
  /// 获取仓库详情
  static Future<Repository> fetchRepos({@required String fullName}) async {
    Map<String, String> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "owner": fullName.split("/")[0],
      "repo": fullName.split("/")[1]
    };
    var result = await DioUtils().get("/api/v5/repos/${fullName}", params: params);
    return Repository.fromJson(result);
  }

  /// 获取指定仓库readme
  static Future<Readme> fetchReadme({@required String fullName}) async {
    Map<String, String> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "owner": fullName.split("/")[0],
      "repo": fullName.split("/")[1]
    };
    var result = await DioUtils().get("/api/v5/repos/${fullName}/readme", params: params);
    return Readme.fromJson(result);
  }

  static Future<List<User>> fetchCollaborators({String fullName}) async {
    Map<String, String> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "owner": fullName.split("/")[0],
      "repo": fullName.split("/")[1]
    };
    List<dynamic> result = await DioUtils().get("/api/v5/repos/${fullName}/collaborators", params: params);
    return result.map((i) => User.fromJson(i)).toList();
  }


  static Future<List<FileTree>> fetchFiles({String fullName, String sha = 'master', String path}) async {
    Map<String, String> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "owner": fullName.split("/")[0],
      "repo": fullName.split("/")[1],
      'sha': sha,
      'path': path
    };
    List<dynamic> result = await DioUtils().get("/api/v5/repos/${fullName}/contents/${path}", params: params);
    return result.map((i) => FileTree.fromJson(i)).toList();
  }

  static Future<List<FileTree>> fetchTree({String fullName, String sha = 'master'}) async {
    Map<String, String> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "owner": fullName.split("/")[0],
      "repo": fullName.split("/")[1],
      'sha': sha
    };
    Map result = await DioUtils().get("/api/v5/repos/${fullName}/git/trees/${sha}", params: params);
    var tree = result['tree'] as List;
    return tree.map((i) => FileTree.fromJson(i)).toList();
  }

  static Future<FileEntity> fetchFile({String fullName, String sha}) async {
    Map<String, String> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "owner": fullName.split("/")[0],
      "repo": fullName.split("/")[1],
      'sha': sha
    };
    var result = await DioUtils().get("/api/v5/repos/${fullName}/git/blobs/${sha}", params: params);
    return FileEntity.fromJson(result);
  }

}