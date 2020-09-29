import 'package:fitee/cache/local_storage.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/model/user/user.dart';
import 'package:fitee/plugin/request/request.dart';
import 'package:flutter/cupertino.dart';

class LoginApi {

  /// 登录
  static Future login({@required String username, @required String password}) async {
    Map<String, String> data = {
      'grant_type': 'password',
      'scope': 'user_info projects pull_requests issues notes keys hook groups gists enterprises emails',
      'client_id': CLIENT_ID,
      'client_secret': CLIENT_SECRET,
      'username': username,
      'password': password
    };
    return await DioUtils().post("/oauth/token", data: data);
  }

  /// 获取用户信息
  static Future<User> getUser() async{
    Map<String, String> params = {"access_token": await DioUtils().getAuthorizationHeader()};
    var result = await DioUtils().get("/api/v5/user", params: params);
    return User.fromJson(result);
  }
}