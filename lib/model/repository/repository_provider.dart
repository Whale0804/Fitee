import 'package:fitee/config/config.dart';
import 'package:fitee/model/readme/readme.dart';
import 'package:fitee/model/repository/repository.dart';
import 'package:fitee/services/repos_service.dart';
import 'package:fitee/utils/utils.dart';
import 'package:flutter/material.dart';

class ReposProvider with ChangeNotifier{

  bool loading = true;

  String status = AppConfig.NORMAL_STATE;

  Repository result;
  Readme readme;

  fetchAll({@required String fullName}) async{
    loading = true;
    Repository repos = await fetchRepos(fullName: fullName);
    await fetchReadme(fullName: fullName);
    loading = false;
    notifyListeners();
    return repos;
  }

  fetchRepos({@required String fullName}) async {
    result = await ReposApi.fetchRepos(fullName: fullName);
    return result;
  }

  fetchReadme({@required String fullName}) async {
    readme = await ReposApi.fetchReadme(fullName: fullName);
    return readme;
  }
}