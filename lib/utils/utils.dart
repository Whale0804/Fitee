
import 'dart:convert';

import 'package:flutter/material.dart';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class Utils {

  static String formatNum(int count) {
    return (count / 1000) > 1 ? _formatNumStr((count / 1000),1) + 'k' : count.toString();
  }
  static String _formatNumStr(double num,int postion){
    if((num.toString().length-num.toString().lastIndexOf(".")-1)<postion){
      //小数点后有几位小数
      return (num.toStringAsFixed(postion).substring(0,num.toString().lastIndexOf(".")+postion+1).toString());
    }else{
      return (num.toString().substring(0,num.toString().lastIndexOf(".")+postion+1).toString());
    }
  }

  // base64编码
  static String base64encode(String content) {
    List<int> bytes = utf8.encode(content);
    return base64Encode(bytes);
  }

  // base64解码
  static String base64decode (String content) {
    List<int> bytes = base64Decode(content);
    return String.fromCharCodes(bytes);
  }
}