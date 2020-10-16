
import 'dart:math';

import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/screen.dart';
import 'package:flutter/material.dart';

class StackAvatar {
  final double width;
  final double offset;

  StackAvatar({this.width = 50.0, this.offset = 20.0});

  int getSpaceStackFlex(BuildContext context, int imageNumber) {
    int maxNum = (MediaQuery.of(context).size.width - 16).toInt();
    int num = (offset * (imageNumber - 1) + duSetWidth(width)).toInt();
    return maxNum - num + 1;
  }

  int getImageStackFlex(BuildContext context, int imageNumber) {
    int num = (offset * (imageNumber - 1) + duSetWidth(width)).toInt();
    return num;
  }

  double getImageStackWidth(int imageNumber) {
    return offset * (imageNumber - 1) + duSetWidth(width);
  }

  List<Widget> getStackItems(List<String> avatar) {
    List<Widget> _list = new List<Widget>();
    for (var i = 0; i < avatar.length; i++) {
      var tempUrl = getRandomInt();
      double off = offset * i;
      _list.add(Positioned(
        left: off,
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.mainBackground,
            shape: BoxShape.circle
          ),
          child: ClipOval(
            child: avatar[i].contains('no_portrait') ? Image.asset(tempUrl,
              width: duSetWidth(width),
              height: duSetWidth(width),
            ) : Image.network(avatar[i],
              width: duSetWidth(width),
              height: duSetWidth(width),
            ),
      ),
        )));
    }
    return _list;
  }


  getRandomInt() {
    var rng = Random();
    return 'assets/avatar/${rng.nextInt(8)}.png';
  }
}