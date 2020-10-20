
import 'package:fitee/model/repository/repository.dart';
import 'package:fitee/plugin/request/request.dart';
import 'package:flutter/material.dart';

class ReposApi {
  /// 获取仓库详情
  static Future<Repository> fetchRepos({@required String fullName}) async {
    Map<String, String> params = {
      "owner": fullName.split("/")[0],
      "repo": fullName.split("/")[1]
    };
    var result = await DioUtils().get("/api/v5/repos/${fullName}", params: params);
    return Repository.fromJson(result);
  }
}