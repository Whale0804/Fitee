
import 'package:fitee/model/letter/letter.dart';
import 'package:fitee/services/letter_service.dart';
import 'package:flutter/material.dart';

class LetterProvider with ChangeNotifier{

  bool loading = true;
  List<Letter> result;

  int currentPage = 1;

  setPage ({int page = 1}){
    currentPage = page;
    fetchLetter();
    notifyListeners();
  }

  fetchLetter() async{
    List<Letter> res = await LetterApi.fetchLetter(page: currentPage);
    if(currentPage == 1){
      result = new List<Letter>();
      result = res;
    }else {
      result.addAll(res);
    }
    loading = false;
    notifyListeners();
    return result;
  }
}