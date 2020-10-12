import 'package:fitee/plugin/request/request.dart';
import 'package:flutter/cupertino.dart';

class FollowApi {
  static Future<dynamic> fetchCheckFollow({@required String username}) async {
    Map<String, dynamic> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "username": username
    };
    return await DioUtils().get("/api/v5/user/following/${username}", params: params);
  }

  static Future<dynamic> fetchFollow({@required String username}) async {
    Map<String, dynamic> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "username": username
    };
    return await DioUtils().put("/api/v5/user/following/${username}", data: params);
  }
}