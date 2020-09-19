import 'dart:io';

import 'package:fitee/pages/login/login_page.dart';
import 'package:fitee/route/base/base_route.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/theme/model/theme_model.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'cache/local_storage.dart';
import 'model/user/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 查看是否登录
  bool isLogin = await LocalStorage.getBool('is_login') ?? false;
  await SystemChrome
      .setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> ThemeModel()),
        ChangeNotifierProvider(create: (_)=> UserProvider()),
      ],
      child: MyApp(isLogin: isLogin),
    )
  ));
}

class MyApp extends StatelessWidget {

  final bool isLogin;
  const MyApp({Key key, this.isLogin}): super(key: key);

  @override
  Widget build(BuildContext context) {

    // 保存 ctx
    NavUtil.ctx = context;

    final _darkMode = Provider.of<ThemeModel>(context).darkMode;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //全局设置透明
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      //虚拟按键颜色
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

//    return MaterialApp(
//      title: 'Fitee',
//      debugShowCheckedModeBanner: false,
//      darkTheme: ThemeData.dark(),
//      theme: ThemeData(
//        textTheme: AppTheme.textTheme,
//        platform: TargetPlatform.iOS,
//      ),
//      home: BaseRoute(),
//    );

    return _darkMode == 2 ?
    MaterialApp(
      title: 'Fitee',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: BaseRoute(),
    ) : MaterialApp(
      title: 'Fitee',
      debugShowCheckedModeBanner: false,
      theme: _darkMode == 1 ? ThemeData.dark() : ThemeData(
        textTheme: AppTheme.textTheme,
        platform: TargetPlatform.iOS,
      ),
      home: isLogin ? BaseRoute() : LoginPage(),
//      home: LoginPage(),
    );
  }
}

