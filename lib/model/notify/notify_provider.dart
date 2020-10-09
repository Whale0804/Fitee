import 'package:fitee/config/config.dart';
import 'package:fitee/model/notify/notify.dart';
import 'package:fitee/model/notify/notify_count.dart';
import 'package:fitee/services/notify_service.dart';
import 'package:flutter/material.dart';

class NotifyProvider with ChangeNotifier {

  bool isHaveNotify = false;

  String allStatus = AppConfig.NORMAL_STATE;
  String myStatus = AppConfig.NORMAL_STATE;

  bool allLoading = true;
  bool myLoading = true;

  List<Notify> allResult;
  List<Notify> myResult;

  int currentAllPage = 1;
  int currentMyPage = 1;

  // 查询未读消息
  fetchCount() async {
    NotifyCount notifyCount = await NotifyApi.fetchCount();
    if(notifyCount != null && notifyCount.totalCount > 0) {
      isHaveNotify = true;
    }
    notifyListeners();
    return isHaveNotify;
  }

  // 设置分页
  setAllPage({int page = 1}) {
    if(page == 1){
      allStatus = AppConfig.NORMAL_STATE;
    }
    currentAllPage = page;
    fetchAllNotify();
    notifyListeners();
  }

  // 查询全部通知
  fetchAllNotify() async {
    try {
      List<Notify> res = await NotifyApi.fetchNotify(page: currentAllPage, type: 'event');
      if (currentAllPage == 1) {
        allResult = new List<Notify>();
        allResult = res;
      } else {
        allResult.addAll(res);
      }
      if(allResult.length == 0){
        allStatus = AppConfig.EMPTY_STATE;
      }
    }catch (e) {
      allResult = new List<Notify>();
      allStatus = AppConfig.ERROR_STATE;
    }
    allLoading = false;
    notifyListeners();
    return allResult;
  }

  //设置分页
  setMyPage({int page = 1}) {
    if(page == 1){
      myStatus = AppConfig.NORMAL_STATE;
    }
    currentMyPage = page;
    fetchMyNotify();
    notifyListeners();
  }
  // 查询@我的
  fetchMyNotify() async {
    try {
      List<Notify> res = await NotifyApi.fetchNotify(page: currentMyPage, type: 'referer');
      if (currentMyPage == 1) {
        myResult = new List<Notify>();
        myResult = res;
      } else {
        myResult.addAll(res);
      }
      if(myResult.length == 0){
        myStatus = AppConfig.EMPTY_STATE;
      }
    }catch(e) {
      myResult = new List<Notify>();
      myStatus = AppConfig.ERROR_STATE;
    }
    myLoading = false;
    notifyListeners();
    return myResult;
  }
}