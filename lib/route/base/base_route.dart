
import 'package:fitee/route/page/base_page.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/widgets/drawer/drawer_custom.dart';
import 'package:fitee/widgets/drawer/drawer_widget.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';

class BaseRoute extends StatefulWidget {

  @override
  _BaseRouteState createState()=> _BaseRouteState();
}

class _BaseRouteState extends State<BaseRoute> {

  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Container(
          color: AppTheme.nearlyWhite,
          child: DrawerWidget(
            screenIndex: DrawerIndex.HOME,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onCellClick: (DrawerIndex drawerIndex) {
              changeIndex(drawerIndex);
            },
            screenView: BasePage()
          ),
        ),
      ),
    );
  }
  void changeIndex(DrawerIndex index) {

  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }
}