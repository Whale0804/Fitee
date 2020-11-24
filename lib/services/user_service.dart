
import 'package:fitee/model/user/user.dart';
import 'package:fitee/plugin/request/request.dart';
import 'package:flutter/material.dart';

class UserApi {

  /// 获取用户信息 [username] : 用户名(username/login)
  static Future<User> fetchUser({@required String username}) async {
    Map<String, String> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "username": username
    };
    var result = await DioUtils().get("/api/v5/users/${username}", params: params);
    return User.fromJson(result);
  }

  /// 获取仓库的所有成员
  static Future<List<User>> fetchCollaborators({@required String fullName}) async {
    Map<String, String> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "owner": fullName.split("/")[0],
      "repo": fullName.split("/")[1],
    };
    List<dynamic> result = await DioUtils().get("/api/v5/repos/${fullName}/collaborators", params: params);
    return result.map((i) => User.fromJson(i)).toList();
  }
}