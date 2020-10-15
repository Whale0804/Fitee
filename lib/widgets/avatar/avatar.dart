
import 'dart:math';

import 'package:fitee/pages/mine_page.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget{

  final String url;
  final String name;
  final double width;
  final double height;

  Avatar({this.url,this.name = '', this.width = 56, this.height = 52});
  @override
  Widget build(BuildContext context) {
    var tempUrl = getRandomInt();
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.05),
          borderRadius: BorderRadius.all(Radius.circular(14.0))
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14.0),
          child: url.contains('no_portrait') ? Image.asset(tempUrl,
            width: duSetWidth(56),
            height: duSetHeight(52),
          ) : Image.network(url,
            width: duSetWidth(56),
            height: duSetHeight(52),
          ),
        ),
        onTap: () {
          if(name != ''){
            if(!url.contains('no_portrait')) {
              tempUrl = url;
            }
            NavUtil.push(MinePage(isCurrent: false, back: true, username: name
                , avatar: tempUrl, netImage: !url.contains('no_portrait'),));
          }
        },
      ),
    );
  }

  getRandomInt() {
    var rng = Random();
    return 'assets/avatar/${rng.nextInt(8)}.png';
  }

}