
import 'package:fitee/config/base_provider.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/model/release/release.dart';
import 'package:fitee/services/release_service.dart';
import 'package:fitee/utils/utils.dart';
import 'package:flutter/material.dart';

class ReleaseProvider extends BaseProvider with ChangeNotifier {

  List<Release> result;

  int currentPage = 1;

  String fullName;

  @override
  setPage({int page = 1}) async {
    if(page == 1){
      status = AppConfig.NORMAL_STATE;
    }
    currentPage = page;
    this.fetchRelease();
  }

  setFullName({String fullName}) async {
    this.fullName = fullName;
    this.setPage();
  }

  fetchRelease() async {
    try{
      List<Release> res = await ReleaseApi.fetchRelease(page: currentPage, fullName: fullName);
      if(currentPage == 1){
        result = new List<Release>();
        result = res;
      }else {
        result.addAll(res);
      }
      if(result.length == 0) {
        status = AppConfig.EMPTY_STATE;
      }
    }catch(e) {
      result = new List<Release>();
      status = AppConfig.ERROR_STATE;
      console.log(e.toString());
    }
    loading = false;
    notifyListeners();
    return result;
  }

  @override
  void onClear() async {
    super.onClear();
  }
}