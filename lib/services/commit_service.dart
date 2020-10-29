import 'package:fitee/model/commit/commit.dart';
import 'package:fitee/plugin/request/request.dart';
import 'package:flutter/material.dart';

class CommitApi {
  /// 获取最后一次commit
  static Future<Commit> fetchLastCommit({@required String fullName}) async {
    Map<String, dynamic> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "owner": fullName.split("/")[0],
      "repo": fullName.split("/")[1],
      "sha": 'master',
    };
    var result = await DioUtils().get("/api/v5/repos/${fullName}/commits/master", params: params);
    return Commit.fromJson(result);
  }
}