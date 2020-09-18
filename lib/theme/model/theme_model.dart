import 'package:fitee/cache/local_storage.dart';
import 'package:flutter/material.dart';

class ThemeModel with ChangeNotifier {
  /// 夜间模式 0: 关闭 1: 开启 2: 随系统
  int _darkMode;

  static const Map<int, String> darkModeMap = {
    0: "关闭",
    1: "开启",
    2: "跟随系统"
  };

  static const String CACHE_KEY = 'darkMode';

  int get darkMode => _darkMode;

  ThemeModel(){
    _init();
  }

  void _init() async {
    int localMode = await LocalStorage.getInt(CACHE_KEY);
    changeMode(localMode);
  }

  void changeMode(int darkMode) async {
    _darkMode = darkMode;

    notifyListeners();

    await LocalStorage.setInt(CACHE_KEY, darkMode);
  }
}