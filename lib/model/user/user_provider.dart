import 'package:fitee/cache/local_storage.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/model/user/user.dart';
import 'package:fitee/services/login_service.dart';
import 'package:fitee/services/user_service.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User user;
  User currentUser;
  bool loading = true;

  getUser() async{
    bool isLogin = await LocalStorage.getBool(AppConfig.LOGIN_KEY)?? false;
    if(isLogin){
      currentUser = await LoginApi.getUser();
      LocalStorage.set(AppConfig.LOGIN_NAME_KEY, currentUser.login);
    }else {
      currentUser = User();
    }
    loading = false;
    notifyListeners();
    return currentUser;
  }

  fetchUser({@required String username}) async{
    user = await UserApi.fetchUser(username: username);
    loading = false;
    notifyListeners();
    return user;
  }
}