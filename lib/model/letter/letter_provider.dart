
import 'package:fitee/config/config.dart';
import 'package:fitee/model/letter/letter.dart';
import 'package:fitee/services/letter_service.dart';
import 'package:flutter/material.dart';

class LetterProvider with ChangeNotifier{

  bool loading = true;
  String status = AppConfig.NORMAL_STATE;

  List<Letter> result;

  int currentPage = 1;

  setPage ({int page = 1}){
    if(page == 1){
      status = AppConfig.NORMAL_STATE;
    }
    currentPage = page;
    fetchLetter();
    notifyListeners();
  }

  fetchLetter() async{
    try {
      List<Letter> res = await LetterApi.fetchLetter(page: currentPage);
      if(currentPage == 1){
        result = new List<Letter>();
        result = res;
      }else {
        result.addAll(res);
      }
      if(result.length == 0){
        status = AppConfig.EMPTY_STATE;
      }
    }catch (e) {
      result = new List<Letter>();
      status = AppConfig.ERROR_STATE;
    }
    loading = false;
    notifyListeners();
    return result;
  }
}