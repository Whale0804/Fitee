import 'package:fitee/config/config.dart';
import 'package:fitee/model/commit/commit.dart';
import 'package:fitee/model/readme/readme.dart';
import 'package:fitee/model/release/release.dart';
import 'package:fitee/model/repository/file_tree.dart';
import 'package:fitee/model/repository/repository.dart';
import 'package:fitee/model/user/user.dart';
import 'package:fitee/services/commit_service.dart';
import 'package:fitee/services/release_service.dart';
import 'package:fitee/services/repos_service.dart';
import 'package:flutter/material.dart';

class ReposProvider with ChangeNotifier{

  bool loading = true;

  String status = AppConfig.NORMAL_STATE;

  // 仓库信息
  Repository result;
  // README 信息
  Readme readme;
  // 最近一次 commit
  Commit commit;
  // 文件树
  List<FileTree> trees;
  // 仓库成员
  List<User> collaborators;
  // 最后一次更新的release
  Release release;


  fetchAll({@required String fullName}) async{
    loading = true;
    Repository repos = await fetchRepos(fullName: fullName);
    await fetchReadme(fullName: fullName);
    await fetchLastCommit(fullName: fullName);
    await fetchFiles(fullName: fullName);
    await fetchLastRelease(fullName: fullName);
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

  fetchCollaborators({@required String fullName}) async {
    collaborators = await ReposApi.fetchCollaborators(fullName: fullName);
    return collaborators;
  }

  fetchLastCommit({@required String fullName}) async {
    commit = await CommitApi.fetchLastCommit(fullName: fullName);
    return commit;
  }

  fetchFiles({@required String fullName, String sha = 'master'}) async {
    trees = await ReposApi.fetchFiles(fullName: fullName, sha: sha);
    return trees.sort((a,b)=>a.mode.compareTo(b.mode));
  }

  fetchLastRelease({String fullName}) async {
    try {
      release = await ReleaseApi.fetchLastRelease(fullName: fullName);
    }catch (e) {
      release = null;
    }
    return release;
  }
}