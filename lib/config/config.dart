
const SERVER_API_URL = 'https://gitee.com';
const GITHUB_SERVER_API_URL = 'https://api.github.com';
const CLIENT_ID = '940dbcb165445181d3bbde6a1715176d92737b16dd71e8b7a7bf4e80597960d5';
const CLIENT_SECRET = 'cc5f4639b918ad2df25a8f8e3578e52312522a7f61462029f3568e60e7410e4c';

class AppConfig {
  AppConfig._();

  /// ================================ 分页字体配置 START ============================
  //每页的数量，最大为 100
  static const int PRE_PAGE = 10;
  static const double EVENT_NAME_SIZE = 18;
  static const double EVENT_TIME_SIZE = 16;
  static const double EVENT_CONTENT_SIZE = 16;
  /// ================================ 分页字体配置 END ============================


  /// ================================ 缓存配置 START ============================
  // 是否开启指纹解锁缓存 Key
  static const String FINGERPRINT_KEY = 'fingerprint_key';
  // 是否登录缓存 Key
  static const String LOGIN_KEY = 'login_key';
  // Token Key
  static const String TOKEN_KEY = 'token_key';
  // user name key
  static const String USER_NAME_KEY = "user_name_key";
  // user name key
  static const String USER_PASS_KEY = "user_pass_key";
  // login name key
  static const String LOGIN_NAME_KEY = "login_name_key";
/// ================================ 缓存配置 END ============================
}