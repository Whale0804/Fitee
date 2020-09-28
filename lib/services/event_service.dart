
import 'dart:convert';

import 'package:fitee/cache/local_storage.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/model/event/event.dart';
import 'package:fitee/plugin/request/request.dart';

class EventApi {
  static Future<List<Event>> fetchAllEvent({int page = 1}) async{
    String userName = await LocalStorage.get("login_name");
    Map<String, dynamic> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "page": page,
      "per_page" : AppConfig.PRE_PAGE,
    };
    List<dynamic> result = await DioUtils().get("/api/v5/users/${userName}/received_events/public", params: params);
    return result.map((i) => Event.fromJson(i)).toList();
  }

  static Future<List<Event>> fetchMyEvent({int page = 1}) async{
    String userName = await LocalStorage.get("login_name");
    Map<String, dynamic> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "page": page,
      "per_page" : AppConfig.PRE_PAGE,
    };
    List<dynamic> result = await DioUtils().get("/api/v5/users/${userName}/events", params: params);
    return result.map((i) => Event.fromJson(i)).toList();
  }
}