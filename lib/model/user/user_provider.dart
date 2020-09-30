import 'package:fitee/cache/local_storage.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/model/user/user.dart';
import 'package:fitee/services/login_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User user;

  getUser() async{
    bool isLogin = await LocalStorage.getBool(AppConfig.LOGIN_KEY)?? false;
    if(isLogin){
      user = await LoginApi.getUser();
      LocalStorage.set(AppConfig.LOGIN_NAME_KEY, user.login);
      notifyListeners();
    }else {
      user = User();
    }
    return user;
  }
}