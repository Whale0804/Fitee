
import 'package:fitee/cache/local_storage.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/model/notify/notify.dart';
import 'package:fitee/model/notify/notify_count.dart';
import 'package:fitee/plugin/request/request.dart';

class NotifyApi {

  // 查询是否存在未读通知/私信
  static Future<NotifyCount> fetchCount({bool unread = true}) async{
    bool isLogin = await LocalStorage.getBool(AppConfig.LOGIN_KEY) ?? false;
    if(isLogin){
      Map<String, dynamic> params = {
        "access_token": await DioUtils().getAuthorizationHeader(),
        "unread": unread
      };
      var result = await DioUtils().get('/api/v5/notifications/count', params: params);
      return NotifyCount.fromJson(result);
    }
    return null;
  }

  // 查询通知
  static Future<List<Notify>> fetchNotify({int page = 1, String type = 'event'}) async {
    Map<String, dynamic> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "page": page,
      "per_page": AppConfig.PRE_PAGE,
      "unread": false,
      "type": type
    };
    Map<String, dynamic> result = await DioUtils().get("/api/v5/notifications/threads", params: params);
    if(result != null){
      List<dynamic> list = result['list'];
      return list.map((i) => Notify.fromJson(i)).toList();
    }
    return List<Notify>();
  }
}