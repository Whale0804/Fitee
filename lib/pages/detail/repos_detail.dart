import 'dart:io';

import 'package:badges/badges.dart';
import 'package:fitee/model/repository/file_tree.dart';
import 'package:fitee/model/repository/repository.dart';
import 'package:fitee/model/repository/repository_provider.dart';
import 'package:fitee/model/user/user_provider.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/relative_date_format.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/store.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/avatar/avatar.dart';
import 'package:fitee/widgets/loading/FiteeLoading.dart';
import 'package:fitee/widgets/markdown/markdown.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:like_button/like_button.dart';

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

  bool isOpen = false;
  double height = 0.0;
  double opacityLevel = 0.0;

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
        return Stack(
          children: <Widget>[
            Container(
              color: HexColor('#6A60C4').withOpacity(appBarAlpha),
              child: Scaffold(
                body: state.loading ? FiteeLoading() : FadeTransition(
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
                        color: appBarAlpha == 0 ?  Colors.white : HexColor('#5A96F6').withOpacity(appBarAlpha),
                      ),
                      Expanded(
                        child: Container(
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
                                    // 项目描述
                                    Container(
                                      key: _key,
                                      width: double.infinity,
                                      padding: EdgeInsets.only(top: duSetHeight(4),bottom: duSetHeight(16), left: duSetWidth(16), right: duSetWidth(16)),
                                      decoration: BoxDecoration(
                                        color: appBarAlpha == 0 ?  Colors.white : HexColor('#5A96F6').withOpacity(appBarAlpha),
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(45)),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey[400].withOpacity(appBarAlpha),
                                              offset: Offset(0.0, 4.0), //阴影xy轴偏移量
                                              blurRadius: 20.0, //阴影模糊程度
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
                                                          color: HexColor('#6A60C4'),
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
                                              // 收藏、关注、Issues
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
                                                        AppTheme.mainBoxShadow
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
                                                                width: duSetWidth(24),
                                                                height: duSetHeight(24),
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
                                                      Expanded(
                                                        child: Container(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: <Widget>[
                                                              Image.asset('assets/icon/issues.png',
                                                                color: AppTheme.nearlyBlack,
                                                                width: duSetWidth(24),
                                                                height: duSetHeight(24),
                                                              ),
                                                              SizedBox(height: duSetWidth(8)),
                                                              Text(Utils.formatNum(state.result.openIssuesCount),
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

                                              // 其他信息
                                              Padding(
                                                padding: EdgeInsets.only(left: duSetWidth(16), right: duSetWidth(16), bottom: duSetHeight(12)),
                                                child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                                        boxShadow: [
                                                          AppTheme.mainBoxShadow
                                                        ]
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: <Widget>[
                                                        Container(
                                                          width: double.infinity,
                                                          height: duSetHeight(40),
                                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            mainAxisSize: MainAxisSize.max,
                                                            children: <Widget>[
                                                              SizedBox(width: duSetWidth(6)),
                                                              Image.asset("assets/icon/branches.png", width: duSetWidth(18), height: duSetHeight(18),),
                                                              SizedBox(width: duSetWidth(6)),
                                                              Text(
                                                                'Branches',
                                                                style: TextStyle(
                                                                    fontSize: duSetFontSize(18),
                                                                    color: AppTheme.darkText
                                                                ),
                                                              ),
                                                              SizedBox(width: duSetWidth(15)),
                                                              Expanded(
                                                                child: Text(
                                                                  'master',
                                                                  style: TextStyle(
                                                                      fontSize: duSetFontSize(16),
                                                                      color: AppTheme.descText,
                                                                      fontWeight: FontWeight.w500
                                                                  ),
                                                                  textAlign: TextAlign.right,
                                                                ),
                                                              ),
                                                              SizedBox(width: duSetWidth(12),),
                                                              Icon(Icons.arrow_forward_ios,
                                                                color: Colors.grey,
                                                                size: duSetFontSize(16),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        _divider(),
                                                        InkWell(
                                                          child: Container(
                                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                                            height: duSetHeight(40),
                                                            width: double.infinity,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                SizedBox(width: duSetWidth(6)),
                                                                Image.asset("assets/icon/event.png", width: duSetWidth(18), height: duSetHeight(18),),
                                                                Expanded(
                                                                  child: Container(
                                                                    padding: EdgeInsets.only(left: 8),
                                                                    child: Text('Event',
                                                                      style: TextStyle(
                                                                          fontSize: duSetFontSize(18),
                                                                          color: AppTheme.darkText
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Icon(Icons.arrow_forward_ios,
                                                                  color: Colors.grey,
                                                                  size: duSetFontSize(16),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          onTap: ()=> {

                                                          },
                                                        ),
                                                        _divider(),
                                                        InkWell(
                                                          child: Container(
                                                            padding: EdgeInsets.only(left: 10, right: 10),
                                                            height: duSetHeight(40),
                                                            width: double.infinity,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                SizedBox(width: duSetWidth(6)),
                                                                Image.asset("assets/icon/commit.png", width: duSetWidth(18), height: duSetHeight(18),),
                                                                Expanded(
                                                                  child: Container(
                                                                    padding: EdgeInsets.only(left: 8),
                                                                    child: Text('Commit',
                                                                      style: TextStyle(
                                                                          fontSize: duSetFontSize(18),
                                                                          color: AppTheme.darkText
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Icon(Icons.arrow_forward_ios,
                                                                  color: Colors.grey,
                                                                  size: duSetFontSize(16),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          onTap: ()=> {

                                                          },
                                                        ),
                                                        state.release != null ? _divider() : SizedBox(),
                                                        state.release != null ? InkWell(
                                                          child: Container(
                                                            padding: EdgeInsets.only(left: 10, right: 10),
                                                            height: duSetHeight(40),
                                                            width: double.infinity,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                SizedBox(width: duSetWidth(6)),
                                                                Image.asset("assets/icon/release.png", width: duSetWidth(18), height: duSetHeight(18),),
                                                                Expanded(
                                                                  child: Container(
                                                                    padding: EdgeInsets.only(left: 8),
                                                                    child: Text('Releases',
                                                                      style: TextStyle(
                                                                          fontSize: duSetFontSize(18),
                                                                          color: AppTheme.darkText
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: SizedBox(),
                                                                ),
                                                                Badge(
                                                                  elevation: 0,
                                                                  shape: BadgeShape.circle,
                                                                  padding: EdgeInsets.all(4),
                                                                  badgeColor: HexColor('#FF4242'),
                                                                  badgeContent: null,
                                                                  child: Text(
                                                                    state.release.tagName,
                                                                    style: TextStyle(
                                                                        fontSize: duSetFontSize(16),
                                                                        color: AppTheme.descText,
                                                                        fontWeight: FontWeight.w500
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(width: duSetWidth(8),),
                                                                Icon(Icons.arrow_forward_ios,
                                                                  color: Colors.grey,
                                                                  size: duSetFontSize(16),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          onTap: ()=> {

                                                          },
                                                        ) : SizedBox(),
                                                        state.result.members.length > 1 ? _divider() : SizedBox(),
                                                        state.result.members.length > 1 ? InkWell(
                                                          child: Container(
                                                            padding: EdgeInsets.only(left: 10, right: 10),
                                                            height: duSetHeight(40),
                                                            width: double.infinity,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                SizedBox(width: duSetWidth(6)),
                                                                Image.asset("assets/icon/contributors.png", width: duSetWidth(18), height: duSetHeight(18),),
                                                                Expanded(
                                                                  child: Container(
                                                                    padding: EdgeInsets.only(left: 8),
                                                                    child: Text('Contributors',
                                                                      style: TextStyle(
                                                                          fontSize: duSetFontSize(18),
                                                                          color: AppTheme.darkText
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Badge(
                                                                  elevation: 0,
                                                                  shape: BadgeShape.circle,
                                                                  padding: EdgeInsets.all(4),
                                                                  badgeColor: HexColor('#afcff7'),
                                                                  badgeContent: Text(
                                                                    state.result.members.length.toString(),
                                                                    style: TextStyle(color: Colors.white),
                                                                  ),
                                                                ),
                                                                SizedBox(width: duSetWidth(8),),
                                                                Icon(Icons.arrow_forward_ios,
                                                                  color: Colors.grey,
                                                                  size: duSetFontSize(16),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          onTap: ()=> {

                                                          },
                                                        ) : SizedBox(),
                                                      ],
                                                    ),
                                                  )
                                              ),

                                              // 文件树
                                              Padding(
                                                padding: EdgeInsets.only(top: 0,left: duSetWidth(16), right: duSetWidth(16), bottom: duSetHeight(12)),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.all(Radius.circular(16)),
                                                      // border: Border.all(color: HexColor('#C5E1FE')),
                                                      boxShadow: [
                                                        AppTheme.mainBoxShadow
                                                      ]
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        width: double.infinity,
                                                        padding: EdgeInsets.symmetric(horizontal: duSetWidth(12), vertical: duSetHeight(12)),
                                                        decoration: BoxDecoration(
                                                          color: HexColor('#F0F8FF'),
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(16),
                                                            topRight: Radius.circular(16),
                                                          )
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            ClipRRect(
                                                                child: Avatar(
                                                                  url: state.commit.committer != null ? state.commit.committer.avatar_url : 'no_portrait',
                                                                  name: state.commit.committer != null ? state.commit.committer.name :state.commit.commit.author.name,
                                                                  width: duSetWidth(22),
                                                                  height: duSetHeight(18),
                                                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                                                ),
                                                                borderRadius: BorderRadius.circular(100)
                                                            ),
                                                            SizedBox(width: duSetWidth(5)),
                                                            Container(
                                                              child: Text(state.commit.committer != null ? state.commit.committer.name :state.commit.commit.author.name,
                                                                style: TextStyle(
                                                                  fontSize: duSetFontSize(14),
                                                                  fontWeight: FontWeight.w400,
                                                                  color: AppTheme.darkText
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(width: duSetWidth(5)),
                                                            Expanded(
                                                              child: Container(
                                                                child: Text(state.commit.commit.message,
                                                                  style: TextStyle(
                                                                      fontSize: duSetFontSize(14),
                                                                      color: AppTheme.url
                                                                  ),
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis,
                                                                ),
                                                              )
                                                            ),
                                                            SizedBox(width: duSetWidth(5)),
                                                            Container(
                                                              child: Text(
                                                                RelativeDateFormat.format2(date: state.commit.commit.author.date),
                                                                style: TextStyle(
                                                                  fontSize: duSetFontSize(14),
                                                                  color: AppTheme.descText
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(width: duSetWidth(5)),
                                                            Container(
                                                              child: Center(
                                                                child: GestureDetector(
                                                                  child: Icon(Icons.more_vert,
                                                                    color: AppTheme.nearlyBlack,
                                                                    size: duSetFontSize(24),
                                                                  ),
                                                                  onTap: () {

                                                                  },
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.symmetric(horizontal: duSetWidth(12), vertical: duSetHeight(16)),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            !isOpen ? Container(
                                                              child: Center(
                                                                child: GestureDetector(
                                                                  child: Text('View Code',
                                                                    style: TextStyle(
                                                                        fontSize: duSetFontSize(16),
                                                                        color: AppTheme.url
                                                                    ),
                                                                  ),
                                                                  onTap: () {
                                                                    setState(() {
                                                                      isOpen = true;
                                                                      height = duSetHeight(34) * state.trees.length;
                                                                      opacityLevel = 1.0;
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ) : SizedBox(),
                                                            AnimatedOpacity(
                                                              opacity: opacityLevel,
                                                              duration: Duration(seconds: 1),
                                                              child:  AnimatedContainer(
                                                                duration: Duration(milliseconds: 475),
                                                                height: height,
                                                                width: double.infinity,
                                                                child: ListView.builder(
                                                                  physics: ClampingScrollPhysics(),
                                                                  itemBuilder: (context, index) {
                                                                    FileTree ft = state.trees[index];
                                                                    return Container(
                                                                        padding: EdgeInsets.symmetric(vertical: duSetHeight(6)),
                                                                        height: duSetHeight(34),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                            ft.type == 'tree' ? Image.asset("assets/icon/folder.png", width: duSetWidth(20), height: duSetHeight(20))
                                                                            : Image.asset("assets/icon/file.png", width: duSetWidth(22), height: duSetHeight(22)),
                                                                            SizedBox(width: duSetWidth(6)),
                                                                            Expanded(
                                                                              child: Container(
                                                                                padding: EdgeInsets.only(left: 8),
                                                                                child: Text(ft.path,
                                                                                  style: TextStyle(
                                                                                      fontSize: duSetFontSize(18),
                                                                                      color: AppTheme.darkText
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Icon(Icons.arrow_forward_ios,
                                                                              color: Colors.grey,
                                                                              size: duSetFontSize(16),
                                                                            )
                                                                          ],
                                                                        )
                                                                    );
                                                                  },
                                                                  itemCount: state.trees.length
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // 渲染Markdown
                                              Padding(
                                                padding: EdgeInsets.only(left: duSetWidth(16), right: duSetWidth(16),),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.all(Radius.circular(16)),
                                                      //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
                                                      boxShadow: [
                                                        AppTheme.mainBoxShadow
                                                      ]
                                                  ),
                                                  child: FiteeMarkdown(data: Utils.base64decode(state.readme.content??='')),
                                                ),
                                              ),
                                              SizedBox(height: duSetHeight(60) + MediaQuery.of(context).padding.bottom,)
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
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: 0,
              left: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: duSetHeight(8)),
                    //margin: EdgeInsets.symmetric(horizontal: duSetWidth(6)),
                    decoration: BoxDecoration(
                        color: AppTheme.likeBtnBgColor.withOpacity(blackAlpha),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                          // bottomRight: Radius.circular(30),
                          // bottomLeft: Radius.circular(30),
                        )
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: duSetHeight(25),
                                  child: Center(
                                    child: LikeButton(
                                      size: duSetFontSize(28),
                                      likeBuilder: (bool isLiked){
                                        return Icon(Icons.star, color: isLiked ? AppTheme.likeBtnColor : Colors.white.withOpacity(blackAlpha), size: duSetFontSize(28),);
                                      },
                                      circleColor:CircleColor(start: HexColor('#E26A30'), end: HexColor('#F1CF1E')),
                                      bubblesColor: BubblesColor(
                                        dotPrimaryColor: HexColor('#F6BA26'),
                                        dotSecondaryColor: HexColor('#F4F72A'),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: Text(
                                      'star',
                                      style: TextStyle(
                                        color: AppTheme.white.withOpacity(blackAlpha),
                                        fontSize: duSetFontSize(18)
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: duSetHeight(25),
                                  child: Center(
                                    child: LikeButton(
                                      size: duSetFontSize(26),
                                      likeBuilder: (bool isLiked){
                                        return Icon(Icons.remove_red_eye, color: isLiked ? AppTheme.likeBtnColor : Colors.white.withOpacity(blackAlpha), size: duSetFontSize(26),);
                                      },
                                      circleColor:CircleColor(start: HexColor('#E26A30'), end: HexColor('#F1CF1E')),
                                      bubblesColor: BubblesColor(
                                        dotPrimaryColor: HexColor('#F6BA26'),
                                        dotSecondaryColor: HexColor('#F4F72A'),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Center(
                                    child: Text(
                                      'watch',
                                      style: TextStyle(
                                          color: AppTheme.white.withOpacity(blackAlpha),
                                          fontSize: duSetFontSize(18)
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ),
                          Expanded(
                              child: Column(
                                children: [
                                  SizedBox(height: duSetHeight(4),),
                                  Container(
                                    height: duSetHeight(25),
                                    child: Center(
                                      child: LikeButton(
                                        size: duSetFontSize(28),
                                        likeBuilder: (bool isLiked){
                                          return Icon(Icons.alt_route, color: isLiked ? AppTheme.likeBtnColor : Colors.white.withOpacity(blackAlpha), size: duSetFontSize(26),);
                                        },
                                        circleColor:CircleColor(start: HexColor('#E26A30'), end: HexColor('#F1CF1E')),
                                        bubblesColor: BubblesColor(
                                          dotPrimaryColor: HexColor('#F6BA26'),
                                          dotSecondaryColor: HexColor('#F4F72A'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Center(
                                      child: Text(
                                        'fork',
                                        style: TextStyle(
                                            color: AppTheme.white.withOpacity(blackAlpha),
                                            fontSize: duSetFontSize(18)
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: Platform.isAndroid ? duSetHeight(12) : MediaQuery.of(context).padding.bottom,
                    width: double.infinity,
                    color: blackAlpha == 0 ? AppTheme.white : AppTheme.likeBtnBgColor.withOpacity(blackAlpha),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }


  Widget _divider() {
    return Divider(
      height: 1.2,
      indent: 12,
      endIndent: 12,
      thickness: 1.2,
      color: Colors.grey.withOpacity(.2),
    );
  }
}