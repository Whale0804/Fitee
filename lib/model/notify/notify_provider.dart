import 'package:fitee/model/notify/notify.dart';
import 'package:fitee/model/notify/notify_count.dart';
import 'package:fitee/services/notify_service.dart';
import 'package:flutter/material.dart';

class NotifyProvider with ChangeNotifier {

  bool isHaveNotify = false;

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
    currentAllPage = page;
    fetchAllNotify();
    notifyListeners();
  }

  // 查询全部通知
  fetchAllNotify() async {
    List<Notify> res = await NotifyApi.fetchNotify(page: currentAllPage, type: 'event');
    if(currentAllPage == 1) {
      allResult = new List<Notify>();
      allResult = res;
    }else {
      allResult.addAll(res);
    }
    allLoading = false;
    notifyListeners();
    return allResult;
  }

  //设置分页
  setMyPage({int page = 1}) {
    currentMyPage = page;
    fetchMyNotify();
    notifyListeners();
  }
  // 查询@我的
  fetchMyNotify() async {
    List<Notify> res = await NotifyApi.fetchNotify(page: currentMyPage, type: 'referer');
    if(currentMyPage == 1) {
      myResult = new List<Notify>();
      myResult = res;
    }else {
      myResult.addAll(res);
    }
    myLoading = false;
    notifyListeners();
    return myResult;
  }
}