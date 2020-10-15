

import 'package:fitee/model/notify/notify_provider.dart';
import 'package:fitee/model/user/user_provider.dart';
import 'package:fitee/pages/event_page.dart';
import 'package:fitee/pages/home_page.dart';
import 'package:fitee/pages/mine_page.dart';
import 'package:fitee/pages/notice_page.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/store.dart';
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
    _initData(NavUtil.ctx);
    super.initState();
  }

  _initData(BuildContext context) async{
    Store.value<UserProvider>(context).getUser();
    Store.value<NotifyProvider>(context).fetchCount();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: FutureBuilder<bool>(
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
        tabBody = EventPage();
      } else if(index == 2){
        tabBody = NoticePage();
      }else if(index == 3) {
        tabBody = MinePage();
      }
    });
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}