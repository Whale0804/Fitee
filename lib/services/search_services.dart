
import 'package:fitee/config/config.dart';
import 'package:fitee/model/search/search_repos.dart';
import 'package:fitee/model/user/user.dart';
import 'package:fitee/plugin/request/request.dart';

class SearchApi {

  static Future<List<SearchRepos>> fetchRepos(String q, {
    int page = 1,
    String language,
    String sort
  }) async{
    Map<String, dynamic> params = {
      //"access_token": await DioUtils().getAuthorizationHeader(),
      "page": page,
      "per_page" : AppConfig.PRE_PAGE,
      "q" : q,
      "language" : language == 'All' ? null : language,
      "sort" : sort,
      "order" : "desc"
    };
    List<dynamic> result = await DioUtils().get('/api/v5/search/repositories', params: params);
    return result.map((i) => SearchRepos.fromJson(i)).toList();
  }

  static Future<List<User>> fetchUsers(String q, {int page = 1}) async {
    Map<String, dynamic> params = {
      //"access_token": await DioUtils().getAuthorizationHeader(),
      "page": page,
      "per_page" : AppConfig.PRE_PAGE,
      "q" : q,
    };
    List<dynamic> result = await DioUtils().get('/api/v5/search/users', params: params);
    return result.map((i) => User.fromJson(i)).toList();
  }
}