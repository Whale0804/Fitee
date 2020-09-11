
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
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FlatButton(
              child: Text('Progress', style: TextStyle(fontSize: 26)),
              color: Colors.amber[400],
              colorBrightness: Brightness.dark,
              highlightColor: Colors.amber[700],
              onPressed: () {
                Navigator.of(context).pushNamed("progress_route");
              },
            ),
            AppBarWidget(
              title: 'Fitee',
              callBack: (){
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