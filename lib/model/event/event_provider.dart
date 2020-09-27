import 'package:fitee/model/event/event.dart';
import 'package:fitee/services/event_service.dart';
import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {

  bool loading = true;

  List<Event> result;

  int currentPage = 1;

  EventProvider(){
    fetchEvent();
  }

  setPage ({int page = 1}){
    currentPage = page;
    print("currentPage $currentPage");
    fetchEvent();
    notifyListeners();
  }

  fetchEvent() async{
    List<Event> res = await EventApi.fetchEvent(page: currentPage);
    notifyListeners();
    if(currentPage == 1){
      result = new List<Event>();
      result = res;
    }else {
      result.addAll(res);
    }
    loading = false;
    return result;
  }
}