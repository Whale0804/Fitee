import 'package:dio/dio.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/plugin/request/request.dart';

/// 详情页面
class FiteeAPI {
  /// 获取供应商数据
  static Future<Map> getFiteeData() async {
    RequestOptions requestOptions = RequestOptions();
    requestOptions.baseUrl = GITHUB_SERVER_API_URL;
    var response = await DioUtils().get('/repos/githinkcn/Fitee',options: requestOptions);
    return response;
  }
}