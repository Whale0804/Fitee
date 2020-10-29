
import 'package:fitee/model/release/release.dart';
import 'package:fitee/plugin/request/request.dart';

class ReleaseApi {

  // 获取仓库的最后更新的Release
  static Future<Release> fetchLastRelease({String fullName}) async {
    Map<String, String> params = {
      "access_token": await DioUtils().getAuthorizationHeader(),
      "owner": fullName.split("/")[0],
      "repo": fullName.split("/")[1]
    };
    var result = await DioUtils().get("/api/v5/repos/${fullName}/releases/latest", params: params);
    return Release.fromJson(result);
  }
}