 import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/basic_types.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class NoMoreFooter extends Footer{

  final Key key;
  final Color color;
  final String title;

  NoMoreFooter({this.key, this.color = Colors.black45, this.title = ''})
      : super(
    float: true,
    extent: 52.0,
    triggerDistance: 52.0,
  );

  @override
  Widget contentBuilder(BuildContext context, LoadMode loadState, double pulledExtent, double loadTriggerPullDistance, double loadIndicatorExtent, AxisDirection axisDirection, bool float, Duration completeDuration, bool enableInfiniteLoad, bool success, bool noMore) {
    return Container(
      width: double.infinity,
      child: Center(
        child: Text(title,
          style: TextStyle(
            color: color,
            fontSize: duSetFontSize(16),
          ),
        ),
      ),
    );
  }

 }