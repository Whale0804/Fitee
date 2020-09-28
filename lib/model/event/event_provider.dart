import 'package:fitee/model/event/event.dart';
import 'package:fitee/services/event_service.dart';
import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {

  bool allLoading = true;
  bool myLoading = true;

  List<Event> allResult;
  List<Event> myResult;

  int currentAllPage = 1;
  int currentMyPage = 1;

  setAllPage ({int page = 1}){
    currentAllPage = page;
    fetchAllEvent();
    notifyListeners();
  }
  setMyPage ({int page = 1}){
    currentMyPage = page;
    fetchMyEvent();
    notifyListeners();
  }

  fetchAllEvent() async{
    List<Event> res = await EventApi.fetchAllEvent(page: currentAllPage);
    if(currentAllPage == 1){
      allResult = new List<Event>();
      allResult = res;
    }else {
      allResult.addAll(res);
    }
    allLoading = false;
    notifyListeners();
    return allResult;
  }

  fetchMyEvent() async{
    List<Event> res = await EventApi.fetchMyEvent(page: currentMyPage);
    if(currentMyPage == 1){
      myResult = new List<Event>();
      myResult = res;
    }else {
      myResult.addAll(res);
    }
    myLoading = false;
    notifyListeners();
    return myResult;
  }
}