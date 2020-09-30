import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fitee/cache/local_storage.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/pages/login/login_page.dart';
import 'package:fitee/route/base/base_route.dart';
import 'package:fitee/services/login_service.dart';
import 'package:fitee/utils/nav_util.dart';

/*
  * 请求 操作类
  * 单例模式
  * 手册
  * https://github.com/flutterchina/dio/blob/master/README-ZH.md
  *
*/
class DioUtils {
  static DioUtils _instance = DioUtils._internal();
  factory DioUtils() => _instance;

  Dio dio;

  DioUtils._internal() {
    // BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
    BaseOptions options = new BaseOptions(
      // 请求基地址,可以包含子路径
      baseUrl: SERVER_API_URL,
      //连接服务器超时时间，单位是毫秒.
      connectTimeout: 10000,

      // 响应流上前后两次接受到数据的间隔，单位为毫秒。
      receiveTimeout: 5000,

      // Http请求头.
      headers: {},

      /// 请求的Content-Type，默认值是"application/json; charset=utf-8".
      /// 如果您想以"application/x-www-form-urlencoded"格式编码请求数据,
      /// 可以设置此选项为 `Headers.formUrlEncodedContentType`,  这样[Dio]
      /// 就会自动编码请求体.
      contentType: 'application/json; charset=utf-8',

      /// [responseType] 表示期望以那种格式(方式)接受响应数据。
      /// 目前 [ResponseType] 接受三种类型 `JSON`, `STREAM`, `PLAIN`.
      ///
      /// 默认值是 `JSON`, 当响应头中content-type为"application/json"时，dio 会自动将响应内容转化为json对象。
      /// 如果想以二进制方式接受响应数据，如下载一个二进制文件，那么可以使用 `STREAM`.
      ///
      /// 如果想以文本(字符串)格式接收响应数据，请使用 `PLAIN`.
      responseType: ResponseType.json,
    );

    dio = new Dio(options);

    // 添加拦截器
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // 在请求被发送之前做一些事情
      return options; //continue
    }, onResponse: (Response response) {
      // 在返回响应数据之前做一些预处理
      return response; // continue
    }, onError: (DioError e) {
      // 当请求失败时做一些预处理
      return createErrorEntity(e);
    }));
    //dio.interceptors.add(DioLogInterceptor());
  }
  /*
   * 获取token
   */
  getAuthorizationHeader() async {
    return LocalStorage.getString(AppConfig.TOKEN_KEY);
  }

  /// get 操作
  Future get<T>(String path, {dynamic params,Options options,}) async {
    try {
      Options requestOptions = options ?? Options();
      /// 以下三行代码为获取token然后将其合并到header的操作
//      Map<String, dynamic> _authorization = {"access_token": getAuthorizationHeader()};
//      if (_authorization != null) {
//        requestOptions = requestOptions.merge(headers: _authorization);
//      }
      var response = await dio.get<T>(
        path,
        queryParameters: params,
        options: requestOptions,
      );
      return response.data;
    } on DioError catch (e) {
      throw createErrorEntity(e);
    }
  }

  ///  post 操作
  Future post(String path, {dynamic data, Options options}) async {
    Options requestOptions = options ?? Options();

    /// 以下三行代码为获取token然后将其合并到header的操作
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.post(path, data: data, options: requestOptions);
    return response.data;
  }

  ///  put 操作
  Future put(String path, {dynamic data, Options options}) async {
    Options requestOptions = options ?? Options();

    /// 以下三行代码为获取token然后将其合并到header的操作
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.put(path, data: data, options: requestOptions);
    return response.data;
  }

  ///  patch 操作
  Future patch(String path, {dynamic params, Options options}) async {
    Options requestOptions = options ?? Options();

    /// 以下三行代码为获取token然后将其合并到header的操作
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.patch(path, data: params, options: requestOptions);
    return response.data;
  }

  /// delete 操作
  Future delete(String path, {dynamic params, Options options}) async {
    Options requestOptions = options ?? Options();

    /// 以下三行代码为获取token然后将其合并到header的操作
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response =
        await dio.delete(path, data: params, options: requestOptions);
    return response.data;
  }

  ///  post form 表单提交操作
  Future postForm(String path, {dynamic params, Options options}) async {
    Options requestOptions = options ?? Options();

    /// 以下三行代码为获取token然后将其合并到header的操作
    // Map<String, dynamic> _authorization = getAuthorizationHeader();
    // if (_authorization != null) {
    //   requestOptions = requestOptions.merge(headers: _authorization);
    // }
    var response = await dio.post(path,
        data: FormData.fromMap(params), options: requestOptions);
    return response.data;
  }
}

/*
   * error统一处理
   */
// 错误信息
ErrorEntity createErrorEntity(DioError error) {
  switch (error.type) {
    case DioErrorType.CANCEL:
      {
        return ErrorEntity(code: -1, message: "请求取消");
      }
      break;
    case DioErrorType.CONNECT_TIMEOUT:
      {
        return ErrorEntity(code: -1, message: "连接超时");
      }
      break;
    case DioErrorType.SEND_TIMEOUT:
      {
        return ErrorEntity(code: -1, message: "请求超时");
      }
      break;
    case DioErrorType.RECEIVE_TIMEOUT:
      {
        return ErrorEntity(code: -1, message: "响应超时");
      }
      break;
    case DioErrorType.RESPONSE:
      {
        try {
          int errCode = error.response.statusCode;
          // String errMsg = error.response.statusMessage;
          // return ErrorEntity(code: errCode, message: errMsg);
          switch (errCode) {
            case 400:
              {
                return ErrorEntity(code: errCode, message: "请求语法错误");
              }
              break;
            case 401:
              {
                _forwardLogin();
                return ErrorEntity(code: errCode, message: "没有权限");
              }
              break;
            case 403:
              {
                return ErrorEntity(code: errCode, message: "服务器拒绝执行");
              }
              break;
            case 404:
              {
                return ErrorEntity(code: errCode, message: "无法连接服务器");
              }
              break;
            case 405:
              {
                return ErrorEntity(code: errCode, message: "请求方法被禁止");
              }
              break;
            case 500:
              {
                return ErrorEntity(code: errCode, message: "服务器内部错误");
              }
              break;
            case 502:
              {
                return ErrorEntity(code: errCode, message: "无效的请求");
              }
              break;
            case 503:
              {
                return ErrorEntity(code: errCode, message: "服务器挂了");
              }
              break;
            case 505:
              {
                return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
              }
              break;
            default:
              {
                // return ErrorEntity(code: errCode, message: "未知错误");
                return ErrorEntity(
                    code: errCode, message: error.response.statusMessage);
              }
          }
        } on Exception catch (_) {
          return ErrorEntity(code: -1, message: "未知错误");
        }
      }
      break;
    default:
      {
        return ErrorEntity(code: -1, message: error.message);
      }
  }

}
  _forwardLogin () async{
    var fingerprintEnable = await LocalStorage.getBool(AppConfig.FINGERPRINT_KEY)?? false;
    if(fingerprintEnable) {
      var username = LocalStorage.getString(AppConfig.USER_NAME_KEY) ?? '';
      var password = LocalStorage.getString(AppConfig.USER_PASS_KEY) ?? '';
      if(username != '' && password != '') {
        var res = await LoginApi.login(username: username, password: password);
        if(res != null && res['access_token'] != null){
          LocalStorage.set(AppConfig.TOKEN_KEY, res['access_token']);
          LocalStorage.setBool(AppConfig.LOGIN_KEY, true);
          NavUtil.pushReplacement(BaseRoute());
        }else {
          NavUtil.push(LoginPage(enableArrow: true));
        }
      }else{
        NavUtil.push(LoginPage(enableArrow: true));
      }
    }else {
      NavUtil.push(LoginPage(enableArrow: true));
    }
  }
/// 异常处理
class ErrorEntity implements Exception {
  int code;
  String message;
  ErrorEntity({this.code, this.message});

  String toString() {
    if (message == null) return "Exception";
    return "Exception: code $code, $message";
  }
}

//日志拦截器
class DioLogInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) async {
    String requestStr = "\n==================== Request Start====================\n"
        "- URL:\n${options.baseUrl + options.path}\n"
        "- METHOD: ${options.method}\n";

    requestStr += "- HEADER:\n${options.headers.mapToStructureString()}\n";

    final data = options.data;
    if (data != null) {
      if (data is Map)
        requestStr += "- BODY:\n${data.mapToStructureString()}\n";
      else if (data is FormData) {
        final formDataMap = Map()
          ..addEntries(data.fields)
          ..addEntries(data.files);
        requestStr += "- BODY:\n${formDataMap.mapToStructureString()}\n";
      } else
        requestStr += "- BODY:\n${data.toString()}\n";
    }
    requestStr += "\n==================== Request End====================\n";
    print(requestStr);
    return options;
  }

  @override
  Future onError(DioError err) async {
    String errorStr = "\n==================== Error Response Start ====================\n"
        "- URL:\n${err.request.baseUrl + err.request.path}\n"
        "- METHOD: ${err.request.method}\n";

    errorStr +=
    "- HEADER:\n${err.response.headers.map.mapToStructureString()}\n";
    if (err.response != null && err.response.data != null) {
      print('╔ ${err.type.toString()}');
      errorStr += "- ERROR:\n${_parseResponse(err.response)}\n";
    } else {
      errorStr += "- ERRORTYPE: ${err.type}\n";
      errorStr += "- MSG: ${err.message}\n";
    }
    errorStr += "\n==================== Error Response End ====================\n";
    print(errorStr);
    return err;
  }

  @override
  Future onResponse(Response response) async {
    String responseStr =
        "\n==================== Response Start ====================\n"
        "- URL:\n${response.request.uri}\n";
    responseStr += "- HEADER:\n{";
    response.headers.forEach(
            (key, list) => responseStr += "\n  " + "\"$key\" : \"$list\",");
    responseStr += "\n}\n";
    responseStr += "- STATUS: ${response.statusCode}\n";

    if (response.data != null) {
      responseStr += "- BODY:\n ${_parseResponse(response)}";
    }
    responseStr + "\n==================== Response End ====================\n";
    printWrapped(responseStr);
    return response;
  }

  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  String _parseResponse(Response response) {
    String responseStr = "";
    var data = response.data;
    if (data is Map)
      responseStr += data.mapToStructureString();
    else if (data is List)
      responseStr += data.listToStructureString();
    else
      responseStr += response.data.toString();

    return responseStr;
  }
}

extension Map2StringEx on Map {
  String mapToStructureString({int indentation = 2}) {
    String result = "";
    String indentationStr = " " * indentation;
    if (true) {
      result += "{";
      this.forEach((key, value) {
        if (value is Map) {
          var temp = value.mapToStructureString(indentation: indentation + 2);
          result += "\n$indentationStr" + "\"$key\" : $temp,";
        } else if (value is List) {
          result += "\n$indentationStr" +
              "\"$key\" : ${value.listToStructureString(indentation: indentation + 2)},";
        } else {
          result += "\n$indentationStr" + "\"$key\" : \"$value\",";
        }
      });
      result = result.substring(0, result.length - 1);
      result += indentation == 2 ? "\n}" : "\n${" " * (indentation - 1)}}";
    }

    return result;
  }
}

extension List2StringEx on List {
  String listToStructureString({int indentation = 2}) {
    String result = "";
    String indentationStr = " " * indentation;
    if (true) {
      result += "$indentationStr[";
      this.forEach((value) {
        if (value is Map) {
          var temp = value.mapToStructureString(indentation: indentation + 2);
          result += "\n$indentationStr" + "\"$temp\",";
        } else if (value is List) {
          result += value.listToStructureString(indentation: indentation + 2);
        } else {
          result += "\n$indentationStr" + "\"$value\",";
        }
      });
      result = result.substring(0, result.length - 1);
      result += "\n$indentationStr]";
    }

    return result;
  }
}