
import 'package:fitee/model/branches/branches.dart';
import 'package:fitee/plugin/request/request.dart';
import 'package:flutter/material.dart';

class BranchesApi {

  /// 获取项目分支列表
  static Future<List<Branches>> fetchBranchesList({@required String fullName}) async {
    Map<String, String> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "owner": fullName.split("/")[0],
      "repo": fullName.split("/")[1]
    };
    List<dynamic> result = await DioUtils().get("/api/v5/repos/${fullName}/branches", params: params);
    return result.map((i) => Branches.fromJson(i)).toList();
  }
}