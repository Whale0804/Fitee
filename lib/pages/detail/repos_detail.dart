import 'package:fitee/config/config.dart';
import 'package:fitee/model/repository/repository.dart';
import 'package:fitee/model/repository/repository_provider.dart';
import 'package:fitee/model/user/user_provider.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/store.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/avatar/avatar.dart';
import 'package:fitee/widgets/loading/FiteeLoading.dart';
import 'package:fitee/widgets/markdown/markdown.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:fitee/widgets/webview/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

// ignore: must_be_immutable
class ReposDetailPage extends StatefulWidget {

  String fullName;
  String humanName;

  ReposDetailPage({Key key, this.fullName, this.humanName}): super(key: key);

  @override
  _ReposDetailState createState()=> _ReposDetailState();
}


class _ReposDetailState extends State<ReposDetailPage> with TickerProviderStateMixin {

  AnimationController _controller;
  Animation _animation;

  GlobalKey _key = GlobalKey();
  //定义透明度
  double appBarAlpha = 1;
  double blackAlpha = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1375));
    _animation = Tween(
      begin: 0.0,
      end: 2.0,
    ).animate(_controller);
    _initData();
  }

  //滚动的距离
  _onScroll(offset) {
    double alpha = 1 - offset / 100;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }

    setState(() {
      appBarAlpha = alpha;
      blackAlpha = 1 - alpha;
    });
  }

  _initData() async {
    Repository repos = await Store.value<ReposProvider>(NavUtil.ctx).fetchAll(fullName: widget.fullName);
    await Store.value<UserProvider>(NavUtil.ctx).fetchCheckFollow(username: repos.owner.login);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Store.connect<ReposProvider>(builder:(context, state, child) {
        if(!state.loading){
          _controller.forward();
        }
        return Container(
          color: HexColor('#6A60C4').withOpacity(appBarAlpha),
          child: Scaffold(
            body: FadeTransition(
              opacity: _animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AppBarWidget(
                    title: widget.humanName,
                    back: true,
                    iconColor: appBarAlpha == 0 ? AppTheme.nearlyBlack : Colors.white,
                    textColor: appBarAlpha == 0 ? AppTheme.nearlyBlack : Colors.white,
                    color: appBarAlpha == 0 ?  Colors.white : HexColor('#6A60C4').withOpacity(appBarAlpha),
                  ),
                  Expanded(
                    child: state.loading ? FiteeLoading() : Container(
                        width: double.infinity,
                        child: MediaQuery.removeViewPadding(
                          removeTop: true,
                          context: context,
                          child: NotificationListener(
                            // ignore: missing_return
                            onNotification: (ScrollNotification notification) {
                              if (notification is ScrollUpdateNotification &&
                                  notification.depth == 0) {
                                _onScroll(notification.metrics.pixels);
                              }
                            },
                            child: ListView(
                              physics: ClampingScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
                                Container(
                                  key: _key,
                                  width: double.infinity,
                                  padding: EdgeInsets.only(top: duSetHeight(4),bottom: duSetHeight(16), left: duSetWidth(16), right: duSetWidth(16)),
                                  decoration: BoxDecoration(
                                      color: appBarAlpha == 0 ?  Colors.white : HexColor('#6A60C4').withOpacity(appBarAlpha),
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(45)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(appBarAlpha),
                                            offset: Offset(-2.0, 0.0), //阴影xy轴偏移量
                                            blurRadius: 10.0, //阴影模糊程度
                                            spreadRadius: 1.0 //阴影扩散程度
                                        ),
                                      ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                ClipRRect(
                                                    child: Avatar(
                                                      url: state.result.owner.avatar_url,
                                                      name: state.result.owner.login,
                                                      width: duSetWidth(36),
                                                      height: duSetHeight(30),
                                                      borderRadius: BorderRadius.all(Radius.circular(100)),
                                                    ),
                                                    borderRadius: BorderRadius.circular(100)
                                                ),
                                                SizedBox(width: 12),
                                                Text(state.result.owner.name,
                                                  style: TextStyle(
                                                      color: AppTheme.nearlyWhite,
                                                      fontSize: duSetFontSize(20.0),
                                                      fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                                Expanded(child: Text('@' + state.result.owner.login,
                                                  style: TextStyle(
                                                      color: AppTheme.url,
                                                      fontSize: duSetFontSize(20.0),
                                                      fontWeight: FontWeight.w400
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                )) ,
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: duSetWidth(12)),
                                          Container(child: Store.connect<UserProvider>(builder: (context, state, child){
                                            return Image.asset('assets/icon/mutual_following.png', height: duSetHeight(24), width: duSetWidth(24), color: state.isFollow ? Colors.white : AppTheme.nearlyBlack);
                                          }) )
                                        ],
                                      ),
                                      SizedBox(height: duSetHeight(12)),
                                      Container(
                                        width: double.infinity,
                                        child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                              style: TextStyle(
                                                fontSize: duSetFontSize(18),
                                                color: appBarAlpha == 0 ? AppTheme.nearlyBlack.withOpacity(blackAlpha) : AppTheme.nearlyWhite,
                                              ),
                                              children: <InlineSpan>[
                                                TextSpan(text: state.result.description),
                                              ]
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: duSetHeight(14)),
                                Stack(
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(height: duSetHeight(40),),
                                        Container(
                                          constraints: BoxConstraints(
                                              minHeight: MediaQuery.of(context).size.height / 1.9,
                                              maxHeight: double.infinity
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(45),),
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  HexColor('#BEDCFD').withOpacity(appBarAlpha),
                                                  HexColor('#FFFFFF').withOpacity(appBarAlpha),
                                                  HexColor('#F9F9F9')..withOpacity(appBarAlpha),
                                                ],
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                          minHeight: MediaQuery.of(context).size.height / 1.9,
                                          maxHeight: double.infinity
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(45),),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(top: 0,left: duSetWidth(16), right: duSetWidth(16), bottom: duSetHeight(12)),
                                            child: Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(horizontal: duSetWidth(12),vertical: duSetHeight(12)),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                                  //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey[300],
                                                        offset: Offset(0.0, -1.0), //阴影xy轴偏移量
                                                        blurRadius: 30.0, //阴影模糊程度
                                                        spreadRadius: 1.0 //阴影扩散程度
                                                    ),
                                                  ]
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Image.asset('assets/icon/star.png',
                                                            color: AppTheme.nearlyBlack,
                                                            width: duSetWidth(24),
                                                            height: duSetHeight(24),
                                                          ),
                                                          SizedBox(height: duSetWidth(8)),
                                                          Text(Utils.formatNum(state.result.stargazersCount),
                                                            style: TextStyle(
                                                                color: AppTheme.nearlyBlack,
                                                                fontSize: duSetFontSize(18)
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Image.asset('assets/icon/eye.png',
                                                            color: AppTheme.nearlyBlack,
                                                            width: duSetWidth(25),
                                                            height: duSetHeight(25),
                                                          ),
                                                          SizedBox(height: duSetWidth(8)),
                                                          Text(Utils.formatNum(state.result.watchersCount),
                                                            style: TextStyle(
                                                                color: AppTheme.nearlyBlack,
                                                                fontSize: duSetFontSize(18)
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Image.asset('assets/icon/fork.png',
                                                            color: AppTheme.nearlyBlack,
                                                            width: duSetWidth(28),
                                                            height: duSetHeight(28),
                                                          ),
                                                          SizedBox(height: duSetWidth(8)),
                                                          Text(Utils.formatNum(state.result.forksCount),
                                                            style: TextStyle(
                                                                color: AppTheme.nearlyBlack,
                                                                fontSize: duSetFontSize(18)
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: duSetWidth(16), right: duSetWidth(16),),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(16)),
                                                  //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey[300],
                                                        offset: Offset(0.0, -1.0), //阴影xy轴偏移量
                                                        blurRadius: 30.0, //阴影模糊程度
                                                        spreadRadius: 1.0 //阴影扩散程度
                                                    ),
                                                  ]
                                              ),
                                              child: FiteeMarkdown(data: Utils.base64decode(state.readme.content??='')),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.bottom)
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}