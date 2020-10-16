
const SERVER_API_URL = 'https://gitee.com';
const GITHUB_SERVER_API_URL = 'https://api.github.com';
const CLIENT_ID = '940dbcb165445181d3bbde6a1715176d92737b16dd71e8b7a7bf4e80597960d5';
const CLIENT_SECRET = 'cc5f4639b918ad2df25a8f8e3578e52312522a7f61462029f3568e60e7410e4c';

class AppConfig {
  AppConfig._();

  /// ================================ 数据库配置 START ============================
  //每页的数量，最大为 100
  static const String DB_NAME = 'fitee.db';
  static const int DB_VERSION = 1;
  /// ================================ 数据库配置 END ============================


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


/// ================================ 页面状态 START ============================
  // normal state
  static const String NORMAL_STATE = '0';
  // empty state
  static const String EMPTY_STATE = '1';
  // error state
  static const String ERROR_STATE = '2';
  // no more state
  static const String NO_MORE_STATE = '3';
/// ================================ 页面状态 END ============================

/// ================================ 查询条件 START ============================
  // normal state
  static const SEARCH_DATA = [
    ['最佳匹配','收藏数量','Fork数量', '关注数量','更新时间',],
    [ 'All', 'Java', 'JavaScript', 'PHP', 'Python', 'C#', 'Android',
    'Objective-C', 'Go', 'C++', 'HTML', 'C', 'NodeJS', 'Swift'
    'TypeScript', 'Ruby', 'Shell', 'Dart', 'CSS', 'Docker',
    'Lua', 'Scala', 'Matlab', 'Delphi', 'Visual Basic', 'TeX/LaTex',
    'ASP', 'Verilog', 'R', 'ActionScript', 'Groovy', 'Erlang',
    'VimL', 'Perl', 'Assembly', 'Arduino', 'FORTRAM', 'QML', 'PowerShell',
    'Pascal', 'Emacs Lisp', 'Clojure', 'CoffeeScript', 'AutoHotkey',
    'Julia', 'VHDL', 'Elixir', 'Haskell', 'M', 'D', 'Scheme', 'XSLT'
    'Common Lisp', 'Logos', 'Racket', 'OCaml', 'DOT', 'Haxe', 'Coq',
    'Vala', 'Puppet', 'LiveScript', 'Smalltalk', 'Nemerle', 'Eiffel'
    'Prolog', 'Standard ML', 'eC', 'Scilab', 'Ada', 'Slash', 'Awk',
    'ColdFusion', 'wechat', 'Crystal', 'Kotlin', 'SQL', 'Lisp', 'XML',
    'C/C++', 'HTML/CSS', '易语言', '汇编', 'other', 'Pawn', 'Zephir']
  ];
/// ================================ 查询条件 END ============================

}

