import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';

class DiscoveryPage extends StatefulWidget {
  
  @override
  _DiscoveryPageState createState()=> _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppBarWidget(
              title: 'Discovery'
            ),
            Expanded(
                child: Container(
                  child: Center(
                    child: FlutterLogo(size: 150, colors: Colors.red),
                  ),
                )
            ),
          ]
      ),
    );
  }
  
}