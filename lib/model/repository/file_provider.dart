
import 'package:fitee/config/base_provider.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/model/repository/file_entity.dart';
import 'package:fitee/model/repository/file_tree.dart';
import 'package:fitee/services/repos_service.dart';
import 'package:flutter/material.dart';

class FileProvider extends BaseProvider with ChangeNotifier  {

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

  @override
  void onClear() async {
    super.onClear();
    this.trees = [];
    this.fullName = '';
  }

  @override
  void setPage({int page = 1}) {
  }

}