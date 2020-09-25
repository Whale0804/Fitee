import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WorkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppBarWidget(
            title: 'Teamwork',
            back: true,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: WebView(
                initialUrl: 'https://jl.githink.cn/',
              ),
            ),
          )
        ]
      ),
    );
  }

}