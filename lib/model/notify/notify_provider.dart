import 'package:fitee/model/notify/notify_count.dart';
import 'package:fitee/services/notify_service.dart';
import 'package:flutter/material.dart';

class NotifyProvider with ChangeNotifier {

  bool isHaveNotify = false;

  // 查询未读消息
  fetchCount() async {
    NotifyCount notifyCount = await NotifyApi.fetchCount();
    if(notifyCount != null && notifyCount.totalCount > 0) {
      isHaveNotify = true;
    }
    notifyListeners();
    return isHaveNotify;
  }
}