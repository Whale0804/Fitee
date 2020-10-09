import 'package:fitee/config/config.dart';
import 'package:fitee/model/event/event.dart';
import 'package:fitee/services/event_service.dart';
import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {

  bool allLoading = true;
  bool myLoading = true;

  String allStatus = AppConfig.NORMAL_STATE;
  String myStatus = AppConfig.NORMAL_STATE;

  List<Event> allResult;
  List<Event> myResult;

  int currentAllPage = 1;
  int currentMyPage = 1;

  setAllPage ({int page = 1}){
    if(page == 1){
      allStatus = AppConfig.NORMAL_STATE;
    }
    currentAllPage = page;
    fetchAllEvent();
    notifyListeners();
  }

  setMyPage ({int page = 1}){
    if(page == 1){
      myStatus = AppConfig.NORMAL_STATE;
    }
    currentMyPage = page;
    fetchMyEvent();
    notifyListeners();
  }

  fetchAllEvent() async{
    try {
      List<Event> res = await EventApi.fetchAllEvent(page: currentAllPage);
      if (currentAllPage == 1) {
        allResult = new List<Event>();
        allResult = res;
      } else {
        allResult.addAll(res);
      }
      if(allResult.length == 0){
        allStatus = AppConfig.EMPTY_STATE;
      }
    }catch (e) {
      allResult = new List<Event>();
      allStatus = AppConfig.ERROR_STATE;
    }
    allLoading = false;
    notifyListeners();
    return allResult;
  }

  fetchMyEvent() async{
    try {
      List<Event> res = await EventApi.fetchMyEvent(page: currentMyPage);
      if (currentMyPage == 1) {
        myResult = new List<Event>();
        myResult = res;
      } else {
        myResult.addAll(res);
      }
      if(myResult.length == 0){
        myStatus = AppConfig.EMPTY_STATE;
      }
    }catch(e) {
      myResult = new List<Event>();
      myStatus = AppConfig.ERROR_STATE;
    }
    myLoading = false;
    notifyListeners();
    return myResult;
  }
}