
import 'package:fitee/plugin/wave.dart';
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

  @override
  void initState() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      print(version);
    });
    super.initState();
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
                                  fontSize: 20,
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
                          height: 10000,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 100,
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
                                                width: 28,
                                                height: 28,
                                                child: Image.asset('assets/icon/eye.png'),
                                              )
                                            ),
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
                                                  width: 28,
                                                  height: 28,
                                                  child: Image.asset('assets/icon/star.png'),
                                                )
                                            ),
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
                                                  width: 32,
                                                  height: 32,
                                                  child: Image.asset('assets/icon/fork.png'),
                                                )
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 1000,
                                width: double.infinity,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
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