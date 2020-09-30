
import 'package:fitee/pages/about/about_page.dart';
import 'package:fitee/route/page/base_page.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/widgets/drawer/drawer_custom.dart';
import 'package:fitee/widgets/drawer/drawer_widget.dart';
import 'package:flutter/material.dart';

class BaseRoute extends StatefulWidget {

  @override
  _BaseRouteState createState()=> _BaseRouteState();
}

class _BaseRouteState extends State<BaseRoute> {

  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.HOME;
    screenView = BasePage();
    super.initState();
    // 保存 ctx
    NavUtil.ctx = this.context;
  }

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
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onCellClick: (DrawerIndex drawerIndex) {
              changeIndex(drawerIndex);
            },
            screenView: screenView
          ),
        ),
      ),
    );
  }
  void changeIndex(DrawerIndex index) {
    if (drawerIndex != index) {
      drawerIndex = index;
      if (drawerIndex == DrawerIndex.HOME) {
        setState(() => screenView = BasePage());
      } else if (drawerIndex == DrawerIndex.HELP) {

      } else if (drawerIndex == DrawerIndex.FEEDBACK) {

      } else if (drawerIndex == DrawerIndex.INVITE) {

      } else if(drawerIndex == DrawerIndex.ABOUT){
        setState(() => screenView = AboutPage());
      }
    }
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }
}