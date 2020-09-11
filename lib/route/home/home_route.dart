
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/widgets/drawer/drawer_custom.dart';
import 'package:fitee/widgets/drawer/drawer_widget.dart';
import 'package:flutter/material.dart';

class HomeRoute extends StatefulWidget {

  @override
  _HomeRouteState createState()=> _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {

  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerWidget(
            screenIndex: DrawerIndex.HOME,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onCellClick: (DrawerIndex drawerIndex) {
              changeIndex(drawerIndex);
            },
            screenView: Container(
              color: Colors.lightBlue,
            ),
          ),
        ),
      ),
    );
  }
  void changeIndex(DrawerIndex index) {

  }
}