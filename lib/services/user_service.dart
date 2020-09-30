
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
}