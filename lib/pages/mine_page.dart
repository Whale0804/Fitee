
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {

  @override
  _MinePageState createState()=> _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppBarWidget(
                title: 'Mine'
            ),
            Expanded(
                child: Container(
                  child: Center(
                    child: FlutterLogo(size: 150, colors: Colors.yellow),
                  ),
                )
            ),
          ]
      ),
    );
  }

}