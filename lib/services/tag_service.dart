
import 'package:fitee/model/branches/branches.dart';
import 'package:fitee/model/tag/tag.dart';
import 'package:fitee/plugin/request/request.dart';
import 'package:flutter/material.dart';

class TagApi {

  /// 获取项目分支列表
  static Future<List<Tag>> fetchTagList({@required String fullName}) async {
    Map<String, String> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "owner": fullName.split("/")[0],
      "repo": fullName.split("/")[1]
    };
    List<dynamic> result = await DioUtils().get("/api/v5/repos/${fullName}/tags", params: params);
    return result.map((i) => Tag.fromJson(i)).toList();
  }
}