import 'package:fitee/cache/local_storage.dart';
import 'package:fitee/model/user/user.dart';
import 'package:fitee/services/login_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User user;

  getUser() async{
    bool isLogin = await LocalStorage.getBool('is_login')?? false;
    if(isLogin){
      user = await LoginApi.getUser();
      LocalStorage.set('login_name', user.login);
      notifyListeners();
    }else {
      user = User();
    }
    return user;
  }
}