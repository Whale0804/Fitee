
import 'package:fitee/cache/local_storage.dart';
import 'package:fitee/config/base_provider.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/model/user/user.dart';
import 'package:fitee/services/follow_service.dart';
import 'package:fitee/services/login_service.dart';
import 'package:fitee/services/user_service.dart';
import 'package:flutter/material.dart';

class UserProvider extends BaseProvider with ChangeNotifier{

  User user;
  User currentUser;

  List<User> collaborators;

  // 是否关注改用户
  bool isFollow = false;


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

  Future<bool> fetchCheckFollow({@required String username}) async{
    try {
      await FollowApi.fetchCheckFollow(username: username);
      isFollow = true;
    } catch (e) {
      isFollow = false;
    }
    notifyListeners();
    return isFollow;
  }

  Future<bool> fetchFollow({@required String username}) async {
    try {
      await FollowApi.fetchFollow(username: username);
      isFollow = true;
    } catch(e) {
      print(e.toString());
      isFollow = false;
    }
    notifyListeners();
    return isFollow;
  }

  Future<bool> fetchUnFollow({@required String username}) async {
    try {
      await FollowApi.fetchUnFollow(username: username);
      isFollow = false;
    } catch(e) {
      print(e.toString());
      isFollow = true;
    }
    notifyListeners();
    return isFollow;
  }

  fetchCollaborators({String fullName}) async {
    collaborators = await UserApi.fetchCollaborators(fullName: fullName);
    loading = false;
    notifyListeners();
    return collaborators;
  }

  @override
  void onClear() async {
    super.onClear();
  }

  @override
  void setPage({int page = 1}) {
  }
}