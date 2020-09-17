import 'package:package_info/package_info.dart';
import 'package:fitee/services/about_service.dart';
import 'package:flutter/material.dart';

class AboutProvider with ChangeNotifier {
  var result;
  PackageInfo packageInfo;

  AboutProvider() {
    _initData();
  }

  _initData() {
    _getFiteeInfo();
    _getVersionInfo();
  }

  _getFiteeInfo() async {
    result = await FiteeAPI.getFiteeData();
    notifyListeners();
  }

  _getVersionInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    notifyListeners();
  }
}