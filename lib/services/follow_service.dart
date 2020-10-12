import 'package:fitee/plugin/request/request.dart';
import 'package:flutter/cupertino.dart';

class FollowApi {

  /// 检查是否关注
  static Future<Null> fetchCheckFollow({@required String username}) async {
    Map<String, dynamic> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "username": username
    };
    await DioUtils().get("/api/v5/user/following/${username}", params: params);
  }

  /// 关注
  static Future<Null> fetchFollow({@required String username}) async {
    Map<String, dynamic> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "username": username
    };
    await DioUtils().put("/api/v5/user/following/${username}", data: params);
  }

  /// 取消关注
  static Future<Null> fetchUnFollow({@required String username}) async {
    Map<String, dynamic> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "username": username
    };
    await DioUtils().delete("/api/v5/user/following/${username}", params: params);
  }
}