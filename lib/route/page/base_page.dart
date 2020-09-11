
import 'dart:math';

import 'package:fitee/pages/home_page.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/widgets/bottom/TabIconData.dart';
import 'package:fitee/widgets/bottom/bottom_widget.dart';
import 'package:flutter/material.dart';

class BasePage extends StatefulWidget {
  @override
  _BasePageState createState()=> _BasePageState();
}

class _BasePageState extends State<BasePage> {

  Widget tabBody = Container(
    color: AppTheme.white,
  );

  @override
  void initState() {
    tabBody = HomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
          if(!snapshot.hasData) {
            return const SizedBox();
          }else {
            return Stack(
              children: <Widget>[
                tabBody,
                BottomWidget(
                  tabIconList: TabIconData.list,
                  navigationRoute: (int index) {
                    navigationRoute(index);
                  },
                )
              ],
            );
          }
        },
      ),
    );
  }

  navigationRoute(int index){
    setState(() {
      if(index == 0) {
        tabBody = HomePage();
      } else if(index == 1){
        tabBody = Container(
          color: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1),
        );
      } else if(index == 2){
        tabBody = Container(
          color: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1),
        );
      }else if(index == 3) {
        tabBody = Container(
          color: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256), Random().nextInt(256), 1),
        );
      }
    });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}