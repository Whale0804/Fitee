
import 'package:fitee/plugin/wave.dart';
import 'package:fitee/services/about_service.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatefulWidget {

  @override
  _AboutPageState createState()=> _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  String version;
  String buildNumber;
  Map<String,dynamic> repo;
  @override
  void initState(){
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
    
    FiteeAPI.getFiteeData().then((res) {
      repo = {
        "description": res['description'],
        "forks_count": res['forks_count'],
        "stargazers_count": res['stargazers_count'],
        "watchers_count": res['watchers_count']
      };
      print(repo['description']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWidget(
              title: 'About Us'
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: 260,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/about/about-bg.png'),
                            fit: BoxFit.cover
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(height: 50),
                            Center(
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(color: AppTheme.grey.withOpacity(0.6), offset: const Offset(2.0, 4.0), blurRadius: 8),
                                    ],
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                  child: Image.asset('assets/about/logo.jpg'),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: Text(
                                version !=null ? '版本号：' + version : '版本号：1.0.0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ),
                            Expanded(
                              child: const SizedBox(),
                            ),
                            Container(
                              width: double.infinity,
                              height: 70,
                              child: _WaveWidget(marginTop: 0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 90,
                                width: double.infinity,
                                color: Colors.white,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Center(
                                              child: Container(
                                                width: 22,
                                                height: 22,
                                                child: Image.asset('assets/icon/eye.png'),
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Center(
                                              child: Text(
                                                repo != null ? repo['watchers_count'].toString() : '1.6k',
                                                style: TextStyle(color: AppTheme.darkText,
                                                fontSize: 18),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 18, bottom: 18),
                                      child: VerticalDivider(width: 1, color: Colors.grey.withOpacity(.7)),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Center(
                                                child: Container(
                                                  width: 22,
                                                  height: 22,
                                                  child: Image.asset('assets/icon/star.png'),
                                                )
                                            ),
                                            const SizedBox(height: 6),
                                            Center(
                                              child: Text(
                                                repo != null ? repo['stargazers_count'].toString() : '10.6k',
                                                style: TextStyle(color: AppTheme.darkText,
                                                    fontSize: 18),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 18, bottom: 18),
                                      child: VerticalDivider(width: 1, color: Colors.grey.withOpacity(.7)),
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Center(
                                                child: Container(
                                                  width: 26,
                                                  height: 26,
                                                  child: Image.asset('assets/icon/fork.png'),
                                                )
                                            ),
                                            const SizedBox(height: 6),
                                            Center(
                                              child: Text(
                                                repo != null ? repo['forks_count'].toString() : '1.1k',
                                                style: TextStyle(color: AppTheme.darkText,
                                                    fontSize: 18),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(height: 1,color: Colors.grey.withOpacity(.6)),
                              const SizedBox(height: 12),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                child: Container(
                                  padding: EdgeInsets.only(top: 20, left: 18,right: 18,bottom: 18),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.withOpacity(.4)),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(0), 
                                      bottomRight: Radius.circular(30),
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(0)
                                    )
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.only(top: 15,bottom: 15, left: 8, right: 8),
                                        child: Text(
                                          'Fitee',
                                          style: TextStyle(
                                              color: AppTheme.darkText,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Divider(height: 1,color: Colors.grey.withOpacity(.6)),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.only(top: 15,bottom: 15, left: 8, right: 8),
                                        child: Text(
                                          repo != null ? repo['description'] : 'Gitee（码云）的Flutter版',
                                          style: TextStyle(
                                              color: AppTheme.darkText,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ),
                                      ),
                                      Divider(height: 1,color: Colors.grey.withOpacity(.6)),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.only(top: 15,bottom: 15, left: 8, right: 8),
                                        child: Text(
                                          'Flutter 版本：1.20.3',
                                          style: TextStyle(
                                              color: AppTheme.darkText,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ),
                                      ),
                                      Divider(height: 1,color: Colors.grey.withOpacity(.6)),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.only(top: 15,bottom: 15, left: 8, right: 8),
                                        child: Text(
                                          'Dart 版本：2.9.2',
                                          style: TextStyle(
                                              color: AppTheme.darkText,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        'Copyright \u00a9 2019-2020 Whale4Cloud Studio',
                        style: TextStyle(
                          fontSize: 12
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom + 5,
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}


class _WaveWidget extends StatelessWidget {
  final double marginTop;

  const _WaveWidget({
    Key key,
    @required this.marginTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.2,
          child: WaveContainer(
            width: 200,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: marginTop),
            yOffset: -10,
            xOffset: 50,
            color: Colors.grey,
            duration: Duration(seconds: 2, milliseconds: 800),
          ),
        ),
        Opacity(
          opacity: 0.3,
          child: WaveContainer(
            width: 200,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: marginTop),
            yOffset: -10,
            xOffset: 100,
            color: Colors.grey,
            duration: Duration(seconds: 2, milliseconds: 200),
          ),
        ),
        WaveContainer(
          width: 200,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(top: marginTop),
          yOffset: 0,
          xOffset: 0,
          color: Colors.white,
          duration: Duration(seconds: 2, milliseconds: 900),
        ),
      ],
    );
  }
}