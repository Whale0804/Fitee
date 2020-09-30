
import 'package:fitee/cache/local_storage.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState()=> _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
                child: Container(
                  child: Center(
                    child: FlutterLogo(size: 150),
                  ),
                )
            ),
          ]
      ),
    );
  }
}