
import 'dart:math';

import 'package:fitee/pages/mine_page.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget{

  String url;
  String name;

  Avatar({this.url,this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.05),
          borderRadius: BorderRadius.all(Radius.circular(14.0))
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.0),
          child: url.contains('no_portrait') ? Image.asset('assets/avatar/${getRandomInt()}.png',
            width: duSetWidth(56),
            height: duSetHeight(52),
          ) : Image.network(url,
            width: duSetWidth(56),
            height: duSetHeight(52),
          ),
        ),
        onTap: () {
          NavUtil.push(MinePage(isCurrent: false, back: true, username: name));
        },
      ),
    );
  }

  getRandomInt() {
    var rng = Random();
    return rng.nextInt(8);
  }

}