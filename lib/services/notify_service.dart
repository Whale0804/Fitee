
import 'package:fitee/cache/local_storage.dart';
import 'package:fitee/model/notify/notify_count.dart';
import 'package:fitee/plugin/request/request.dart';

class NotifyApi {

  // 查询是否存在未读通知/私信
  static Future<NotifyCount> fetchCount({bool unread = true}) async{
    bool isLogin = await LocalStorage.getBool('is_login') ?? false;
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
}