import 'package:fitee/cache/local_storage.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/model/user/user_provider.dart';
import 'package:fitee/pages/login/login_page.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DrawerCustom extends StatefulWidget {

  final AnimationController iconAnimationController;
  final DrawerIndex screenIndex;
  final Function(DrawerIndex) callBackIndex;

  DrawerCustom({Key key, this.iconAnimationController, this.screenIndex, this.callBackIndex}): super(key: key);

  @override
  _DrawerCustomState createState()=> _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  List<DrawerList> drawerList;
  @override
  void initState() {
    setDrawerListArray();
    super.initState();
  }

  void setDrawerListArray() {
    drawerList = <DrawerList>[
      DrawerList(
        index: DrawerIndex.HOME,
        labelName: 'Home',
        icon: Icon(Icons.home),
      ),
      DrawerList(
        index: DrawerIndex.HELP,
        labelName: 'Help',
        isAssetsImage: true,
        imageName: 'assets/icon/supportIcon.png',
      ),
      DrawerList(
        index: DrawerIndex.FEEDBACK,
        labelName: 'FeedBack',
        icon: Icon(Icons.help),
      ),
      DrawerList(
        index: DrawerIndex.INVITE,
        labelName: 'Invite Friend',
        icon: Icon(Icons.group),
      ),
      DrawerList(
        index: DrawerIndex.SHARE,
        labelName: 'Rate the app',
        icon: Icon(Icons.share),
      ),
      DrawerList(
        index: DrawerIndex.ABOUT,
        labelName: 'About Us',
        icon: Icon(Icons.info),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        width: 375, height: 812 - 44 - 34, allowFontScaling: true);
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (BuildContext context, Widget child) {
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(1.0 - (widget.iconAnimationController.value) * 0.2),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(begin: 0.0, end: 24.0)
                          .animate(CurvedAnimation(parent: widget.iconAnimationController, curve: Curves.fastOutSlowIn)).value / 90),
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: <BoxShadow>[
                                BoxShadow(color: AppTheme.white.withOpacity(0.6), offset: const Offset(2.0, 4.0), blurRadius: 8.0),
                              ],
                              border: Border.all(color: Colors.grey.withOpacity(.5), width: 4),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all((Radius.circular(50.0))),
                              child: Consumer<UserProvider>(
                                  builder: (context, state, child) {
                                    return state != null && state.currentUser != null ? Image.network(state.currentUser.avatar_url) : Image.asset('assets/daniel.jpg') ;
                                  }
                                ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 18, left: 4),
                    child: Consumer<UserProvider>(
                      builder: (context, state, child) {
                        return Text(
                          state != null && state.currentUser != null ? state.currentUser.name : 'Fitee',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            fontSize: 18,
                          ),
                        );
                      },
                    )
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Divider(height: 1, color: AppTheme.grey.withOpacity(0.6)),
          const SizedBox(height: 4),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(0.0),
              physics: const BouncingScrollPhysics(),
              itemCount: drawerList.length,
              itemBuilder: (BuildContext context, int index){
                return inkwell(drawerList[index]);
              },
            ),
          ),
          Divider(height: 1, color: AppTheme.grey.withOpacity(0.6)),
          Column(
            children: <Widget>[
              ListTile(
                title: Text('退 出',
                  style: TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: AppTheme.darkText
                  ),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(Icons.power_settings_new, color: Colors.red),
                onTap: () async{
                  LocalStorage.set(AppConfig.TOKEN_KEY, '');
                  LocalStorage.setBool(AppConfig.LOGIN_KEY, false);
                  NavUtil.pushAndRemove(LoginPage());
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget inkwell(DrawerList data){
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.2),
        highlightColor: Colors.transparent,
        onTap: (){
          navigationtoScreen(data.index);
        },
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 6.0,
                    height: 46.0,
                    decoration: BoxDecoration(
                      color: widget.screenIndex == data.index ? Colors.red[700] : Colors.transparent,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(16),
                      )
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(4.0)),
                  data.isAssetsImage ?
                      Container(
                        width: duSetWidth(24),
                        height: duSetHeight(24),
                        child: Image.asset(
                          data.imageName,
                          color: widget.screenIndex == data.index ? Colors.white: AppTheme.nearlyBlack,
                        ),
                      ) : Icon(data.icon.icon, color: widget.screenIndex == data.index ? Colors.blue : AppTheme.nearlyBlack),
                  const Padding(padding: EdgeInsets.all(4.0)),
                  Text(
                      data.labelName,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: widget.screenIndex == data.index ? Colors.blue : AppTheme.nearlyBlack),
                      textAlign: TextAlign.left
                  )
                ],
              ),
            ),
            widget.screenIndex == data.index ?
                AnimatedBuilder(
                  animation: widget.iconAnimationController,
                  builder: (BuildContext context, Widget child) {
                    return Transform(
                      transform: Matrix4.translationValues(
                          (MediaQuery.of(context).size.width * 0.75 - 64) * (1.0 - widget.iconAnimationController.value -1.0), 0.0, 0.0),
                      child: Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.75 - 64,
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.red[800].withOpacity(0.2),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(28),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(28)
                            )
                          ),
                        ),
                      ),
                    );
                  },
                ) : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> navigationtoScreen(DrawerIndex indexScreen) async {
    widget.callBackIndex(indexScreen);
  }
}

class DrawerList {
  DrawerList({
    this.isAssetsImage = false,
    this.labelName = '',
    this.icon,
    this.index,
    this.imageName = '',
  });

  String labelName;
  Icon icon;
  bool isAssetsImage;
  String imageName;
  DrawerIndex index;
}


enum DrawerIndex {
  HOME,
  FEEDBACK,
  HELP,
  SHARE,
  ABOUT,
  INVITE,
  TESTING,
}