
import 'package:fitee/cache/local_storage.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';

import 'login/login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState()=> _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initData();
  }


  _initData() async{
    // 查看是否登录
    bool isLogin = await LocalStorage.getBool(AppConfig.LOGIN_KEY) ?? false;
    if(!isLogin){
      NavUtil.pushAndRemove(LoginPage(enableArrow: false));
    }
  }

  @override
  Widget build(BuildContext context) {

    _searchController.addListener(() {
      setState(() {});
    });

    return Container(
      color: AppTheme.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppBarWidget(
              title: 'Fitee',
              callBack: () async {
                print(await LocalStorage.get(AppConfig.TOKEN_KEY));
                print("click homePage title right icon.");
              },
              icon: Icon(Icons.dashboard),
            ),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: duSetHeight(60),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200],
                            offset: Offset(15, 4.0),
                            blurRadius: 16,
                            spreadRadius: .6
                          )
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            color: HexColor('#BEDCFD')
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(width: duSetWidth(10)),
                            Icon(Icons.search, color: Colors.white, size: duSetHeight(24)),
                            SizedBox(width: duSetWidth(10)),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: '输入关键字搜索仓库/用户...',
                                  hintStyle: TextStyle(
                                    fontSize: duSetFontSize(16),
                                    color: Colors.black45
                                  ),
                                  border: InputBorder.none,
                                ),
                                maxLines: 1,
                                textInputAction: TextInputAction.search,
                                style: TextStyle(
                                  fontSize: duSetFontSize(16)
                                ),
                                onSubmitted: (value){
                                  print(value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: duSetHeight(85)),
                          Image.asset('assets/logo.png', width: duSetWidth(110), height: duSetHeight(110)),
                          SizedBox(height: duSetHeight(15)),
                          Text(
                            'Fitee For 码云',
                            style: TextStyle(
                              fontSize: duSetFontSize(32),
                              color: Colors.black87,
                              fontWeight: FontWeight.w500
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: duSetHeight(30),),
          ]
      ),
    );
  }
}