import 'package:fitee/config/config.dart';
import 'package:fitee/model/repository/repository.dart';
import 'package:fitee/services/repos_service.dart';
import 'package:flutter/material.dart';

class ReposProvider with ChangeNotifier{

  bool loading = true;

  String status = AppConfig.NORMAL_STATE;

  Repository result;

  fetchRepos({@required String fullName}) async {
    loading = true;
    result = await ReposApi.fetchRepos(fullName: fullName);
    loading = false;
    notifyListeners();
    return result;
  }
}