
import 'package:fitee/config/config.dart';
import 'package:fitee/model/search/search_repos.dart';
import 'package:fitee/model/user/user.dart';
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {

  String reposStatus = AppConfig.NORMAL_STATE;
  String userStatus = AppConfig.NORMAL_STATE;

  bool reposLoading = true;
  bool userLoading = true;

  List<SearchRepos> reposResult;
  List<User> userResult;

  int currentReposPage = 1;
  int currentUserPage = 1;
}