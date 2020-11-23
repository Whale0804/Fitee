
import 'package:fitee/config/config.dart';
import 'package:fitee/model/repository/file_entity.dart';
import 'package:fitee/model/repository/file_tree.dart';
import 'package:fitee/services/repos_service.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FileProvider with ChangeNotifier {

  bool loading = true;

  String status = AppConfig.NORMAL_STATE;

  // 文件树
  List<FileTree> trees;

  FileEntity file;

  String fullName;

  fetchTree({@required String fullName, String sha = 'master'}) async {
    trees = await ReposApi.fetchTree(fullName: fullName, sha: sha);
    trees.sort((a,b)=>a.mode.compareTo(b.mode));
    loading = false;
    notifyListeners();
    return trees;
  }

  fetchFile({@required String fullName, @required String sha}) async {
    file = await ReposApi.fetchFile(fullName: fullName, sha: sha);
    loading = false;
    notifyListeners();
    return file;
  }

  setClear() {
    this.loading = true;
    this.trees = [];
    this.fullName = '';
  }

}