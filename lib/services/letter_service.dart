
import 'package:fitee/config/config.dart';
import 'package:fitee/model/letter/letter.dart';
import 'package:fitee/plugin/request/request.dart';

class LetterApi {
  static Future<List<Letter>> fetchLetter({int page = 1}) async{
    Map<String, dynamic> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "unread": false,
      "page": page,
      "per_page" : AppConfig.PRE_PAGE,
    };
    Map<String, dynamic> result = await DioUtils().get("/api/v5/notifications/messages", params: params);
    if(result != null){
       List<dynamic> list = result['list'];
      return list.map((i) => Letter.fromJson(i)).toList();
     }
    return List<Letter>();
  }
}