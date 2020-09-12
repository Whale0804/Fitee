
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget{

  @override
  _NoticePageState createState()=> _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppBarWidget(
                title: 'Notice'
            ),
            Expanded(
                child: Container(
                  child: Center(
                    child: FlutterLogo(size: 150, colors: Colors.green),
                  ),
                )
            ),
          ]
      ),
    );
  }
}