import 'package:fitee/cache/local_storage.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/model/user/user.dart';
import 'package:fitee/model/user/user_provider.dart';
import 'package:fitee/pages/about/about_page.dart';
import 'package:fitee/pages/settings/setting_page.dart';
import 'package:fitee/plugin/toast.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/store.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/bubble%20/bubble.dart';
import 'package:fitee/widgets/dashes_separator.dart';
import 'package:fitee/widgets/loading/FiteeLoading.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MinePage extends StatefulWidget {
  final bool isCurrent;
  final bool back;
  final String username;
  final String avatar;
  final bool netImage;

  MinePage({Key key, this.isCurrent = true, this.back = false, this.username, this.avatar = '', this.netImage = true}): super(key: key);

  @override
  _MinePageState createState()=> _MinePageState();
}

class _MinePageState extends State<MinePage> {

  UserProvider _userProvider;

  @override
  void initState() {
    _userProvider = Store.value<UserProvider>(NavUtil.ctx);
    _initData();
    super.initState();
  }

  _initData() async {
    if(widget.isCurrent){
      String username = await LocalStorage.getString(AppConfig.LOGIN_NAME_KEY);
      _userProvider.fetchUser(username: username);
    }else {
      // 根据用户名获取用户
      _userProvider.fetchUser(username: widget.username);
      _userProvider.fetchCheckFollow(username: widget.username);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Store.connect<UserProvider>(builder: (context, state,child) {
      return state.loading ? FiteeLoading() : Container(
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppBarWidget(
                title: widget.isCurrent ? '我 的' : state.user != null ? state.user.name : '我的',
                icon: widget.back ? null : Icon(Icons.settings),
                back: widget.back,
                callBack: () {
                  NavUtil.push(SettingPage());
                },
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Stack(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: duSetHeight(120)),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: HexColor('#E2E7F3'),
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                              ),
                            ),
                          )
                        ],
                      ),
                      ListView(
                        physics: ClampingScrollPhysics(),
                        padding: EdgeInsets.only(top: duSetHeight(12)),
                        children: [
                          // 用户信息
                          _UserCard(context),
                          // 仓库等信息
                          _ReposCard(context),
                          // 操作列表
                          _ActionCard(context),
                          // 用户信息
                          _InfoCard(context),
                          // 其他操作
                          widget.isCurrent ? _OtherCard(context) : SizedBox(),
                          SizedBox(height: duSetHeight(65))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]
        ),
      );
    });
  }

  // Widgets
  Widget _UserCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0,left: duSetWidth(16), right: duSetWidth(16), bottom: duSetHeight(12)),
      child: Consumer<UserProvider>(
        builder: (context, state, child) {
          return Container(
            padding: EdgeInsets.all(12),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      //color: Colors.grey.withOpacity(.05),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 0),
                        transitionBuilder: (Widget child, Animation<double> animation) {
                          // 执行动画
                          return ScaleTransition(child: child,scale: animation);
                        },
                        child: ClipRRect(
                          key: ValueKey<int>( state.user != null ? state.user.id : 0),
                          borderRadius: BorderRadius.circular(110.0),
                          child: widget.avatar != '' ?  _ImageAvatar() :  state.user != null ? Image.network(state.user.avatar_url, width: 110,height: 110) : Image.asset('assets/icon/user.png', width: 110,height: 110),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          AnimatedSwitcher(duration: const Duration(milliseconds: 0),
                              transitionBuilder: (Widget child, Animation<double> animation) {
                                // 执行动画
                                return ScaleTransition(child: child,scale: animation);
                              },
                              child: Text(state.user != null ? state.user.name : '',
                                key: ValueKey<int>( state.user != null ? state.user.id : 0),
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: duSetFontSize(22),
                                    fontWeight: FontWeight.w600
                                ),
                                textAlign: TextAlign.left,
                              ),
                          ),
                          SizedBox(height: duSetHeight(4)),
                          Text(state.user != null ? '@' + state.user.login : '一个程序员',
                            style: TextStyle(
                                color: HexColor('#829099'),
                                fontSize: duSetFontSize(16)
                            ),
                          ),
                          SizedBox(height: duSetHeight(4)),
                          Container(
                            height: duSetHeight(48),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                color: HexColor('#EFF3F9')
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(height: duSetHeight(6)),
                                          Text('watched',
                                            style: TextStyle(
                                                color: AppTheme.descText,
                                                fontSize: duSetFontSize(12)
                                            ),
                                          ),
                                          SizedBox(height: duSetHeight(4)),
                                          Text(state.user != null ? state.user.watched.toString() : '0',
                                            style: TextStyle(
                                                fontSize: duSetFontSize(18),
                                                color: AppTheme.darkText,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(height: duSetHeight(6)),
                                          Text('followers',
                                            style: TextStyle(
                                                color: AppTheme.descText,
                                                fontSize: duSetFontSize(12)
                                            ),
                                          ),
                                          SizedBox(height: duSetHeight(4)),
                                          Text(state.user != null ? state.user.followers.toString() : '0',
                                            style: TextStyle(
                                                fontSize: duSetFontSize(18),
                                                color: AppTheme.darkText,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(height: duSetHeight(6)),
                                          Text('following',
                                            style: TextStyle(
                                                color: AppTheme.descText,
                                                fontSize: duSetFontSize(12)
                                            ),
                                          ),
                                          SizedBox(height: duSetHeight(4)),
                                          Text(state.user != null ? state.user.following.toString() : '0',
                                            style: TextStyle(
                                                fontSize: duSetFontSize(18),
                                                color: AppTheme.darkText,
                                                fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: duSetHeight(!widget.isCurrent ? 13 : 0)),
                !widget.isCurrent ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child:Center(
                        child: Container(
                          width: duSetWidth(140),
                          height: duSetHeight(40),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1,color: HexColor('#607383')),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: FlatButton(
                            colorBrightness: Brightness.dark,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            onPressed: () async {
                              if(state.isFollow) { // 取消关注
                                await state.fetchUnFollow(username: state.user.login);
                              }else { // 关注
                                await state.fetchFollow(username: state.user.login);
                              }
                            },
                            child: Text(
                              state.isFollow ? "已 关 注" : "关 注",
                              style: TextStyle(
                                  fontSize: duSetFontSize(15),
                                  fontWeight: FontWeight.w500,
                                  color: HexColor('#607383')
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: duSetWidth(20)),
                    Expanded(
                      child: Center(
                        child: Container(
                          width: duSetWidth(140),
                          height: duSetHeight(40),
                          child: FlatButton(
                            colorBrightness: Brightness.dark,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            onPressed: () async{
                              _openChatWidget(context: context, user: state.user);
                            },
                            child: Text(
                              "私 信",
                              style: TextStyle(
                                  fontSize: duSetFontSize(15),
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white
                              ),
                            ),
                            color: HexColor('#3F69F9'),
                          ),
                        ),
                      ),
                    )
                  ],
                ) : SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _ImageAvatar ({double width = 110, double height = 110}) {
    if(widget.avatar != '' && widget.netImage) {
      return Image.network(widget.avatar, width: width, height: height);
    }else {
      return Image.asset(widget.avatar, width: width, height: height);
    }
  }
  Widget _ReposCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: duSetWidth(16), right: duSetWidth(16), bottom: duSetHeight(12)),
      child: Container(
        width: double.infinity,
        height: duSetHeight(60),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Consumer<UserProvider>(
          builder: (context, state, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _ReposItem(
                  title: 'Repos',
                  count: state.user != null ? state.user.public_repos : 0
                ),
                VerticalDivider(
                  color: Colors.grey.withOpacity(.2),
                  indent: 12, // 相当于 marginTop
                  endIndent: 12,
                  thickness: 1.2,
                ),

                _ReposItem(
                    title: 'Watched',
                    count: state.user != null ? state.user.watched : 0
                ),
                VerticalDivider(
                  color: Colors.grey.withOpacity(.2),
                  indent: 12, // 相当于 marginTop
                  endIndent: 12,
                  thickness: 1.2,
                ),
                _ReposItem(
                    title: 'Gists',
                    count: state.user != null ? state.user.public_gists : 0
                ),
              ],
            );
          }
        )
      ),
    );
  }
  Widget _ReposItem({String title, int count = 0}) {
    return Expanded(
      child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: duSetHeight(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(count.toString(),
                    style: TextStyle(
                        color: AppTheme.darkText,
                        fontSize: duSetFontSize(18),
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                Expanded(
                    child:Text(title,
                      style: TextStyle(
                          color: AppTheme.descText,
                          fontSize: duSetFontSize(16),
                          fontWeight: FontWeight.w400
                      ),
                    )
                )
              ],
            ),
          )
      ),
    );
  }
  Widget _ActionCard(BuildContext context){
    return Padding(
          padding: EdgeInsets.only(left: duSetWidth(16), right: duSetWidth(16), bottom: duSetHeight(12)),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    height: duSetHeight(40),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Text('Issues',
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
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Text('Orgs',
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
                    Toast.toast(
                      context,
                      msg: 'Orgs',
                      showTime: 3000,
                    )
                  },
                )
              ],
            ),
          )
      );
  }
  Widget _InfoCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: duSetWidth(16), right: duSetWidth(16),bottom: duSetHeight(12)),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Consumer<UserProvider>(
          builder: (context, state, child) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: duSetHeight(40),
                      width: double.infinity,
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 8),
                              child: Text('Email',
                                style: TextStyle(
                                    fontSize: duSetFontSize(18),
                                    color: AppTheme.darkText
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(state.user != null && state.user.email != null ? state.user.email : '--',
                                  style: TextStyle(
                                    color: AppTheme.descText,
                                    fontSize: duSetFontSize(16)
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                  _divider(),
                  Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: duSetHeight(40),
                      width: double.infinity,
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 8),
                              child: Text('Blog',
                                style: TextStyle(
                                    fontSize: duSetFontSize(18),
                                    color: AppTheme.darkText
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(state.user != null && state.user.blog != null ? state.user.blog : '--',
                                  style: TextStyle(
                                      color: AppTheme.descText,
                                      fontSize: duSetFontSize(16),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                  _divider(),
                  Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: duSetHeight(40),
                      width: double.infinity,
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 8),
                              child: Text('Weibo',
                                style: TextStyle(
                                    fontSize: duSetFontSize(18),
                                    color: AppTheme.darkText
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(state.user != null && state.user.weibo != null ? state.user.weibo : '--',
                                  style: TextStyle(
                                    color: AppTheme.descText,
                                    fontSize: duSetFontSize(16),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            )
                          ],
                        ),
                        onTap: ()=> {
                          Toast.toast(
                            context,
                            msg: 'Issues',
                            showTime: 3000,
                          )
                        },
                      )
                  ),
                  _divider(),
                  Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: duSetHeight(40),
                      width: double.infinity,
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 8),
                              child: Text('Company',
                                style: TextStyle(
                                    fontSize: duSetFontSize(18),
                                    color: AppTheme.darkText
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(state.user != null && state.user.company != null ? state.user.company : '--',
                                  style: TextStyle(
                                    color: AppTheme.descText,
                                    fontSize: duSetFontSize(16),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  ),
                ]
            );
          },
        )
      )
    );
  }
  Widget _OtherCard(BuildContext context){
    return Padding(
        padding: EdgeInsets.only(left: duSetWidth(16), right: duSetWidth(16), bottom: duSetHeight(12)),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  height: duSetHeight(40),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 8),
                          child: Text('Feedback',
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
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 8),
                          child: Text('About',
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
                  NavUtil.push(AboutPage(back: true))
                },
              )
            ],
          ),
        )
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

  _openChatWidget({BuildContext context, User user}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true, //可滚动 解除showModalBottomSheet最大显示屏幕一半的限制
        shape: RoundedRectangleBorder(
          //圆角
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        builder: (BuildContext context) {
          return AnimatedPadding(
            //showModalBottomSheet 键盘弹出时自适应
            padding: MediaQuery.of(context).viewInsets, //边距（必要）
            duration: const Duration(milliseconds: 100), //时常 （必要）
            child: Container(
              // height: 180,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height / 1.3, //设置最小高度（必要）
                maxHeight: MediaQuery.of(context).size.height / 1.3, //设置最大高度（必要）
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(40)), color: Colors.white), //圆角
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: duSetHeight(60),
                    padding: EdgeInsets.symmetric(vertical: duSetHeight(5)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            child: widget.avatar != '' ?  _ImageAvatar(width: 50, height: 50)
                                : Image.network(user.avatar_url, width: 50, height: 50),
                            borderRadius: BorderRadius.circular(25)
                          ),
                          SizedBox(width: 10,),
                          RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(style: TextStyle(
                              fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE),
                              color: AppTheme.darkText,
                            ), children: <InlineSpan>[
                              TextSpan(text: user.name, style: TextStyle(
                                  color: AppTheme.darkText,
                                  fontSize: duSetFontSize(18.0),
                                  fontWeight: FontWeight.w500
                              )),
                              TextSpan(text: '@' + user.login,style: TextStyle(
                                color: AppTheme.url,
                                fontSize: duSetFontSize(18.0),
                                fontWeight: FontWeight.w400
                              )),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DashesSeparator(color: Colors.grey[300].withOpacity(.8)),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          color: AppTheme.background,
                          child: Column(
                            children: <Widget>[
                              Flexible(
                                child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  itemCount: 1,
                                  reverse: true,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: duSetHeight(6)),
                                            child: Text(
                                              'Feb 25, 2018',
                                              style:
                                              TextStyle(color: Colors.grey, fontSize: duSetFontSize(13)),
                                            ),
                                          ),
                                          Bubble(
                                            message: 'Hi How are you ?',
                                            isMe: true,
                                          ),
                                          Bubble(
                                            message: 'have you seen the docs yet?',
                                            isMe: true,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: duSetHeight(6)),
                                            child: Text(
                                              'Today',
                                              style:
                                              TextStyle(color: Colors.grey, fontSize: duSetFontSize(13)),
                                            ),
                                          ),
                                          Bubble(
                                            message: 'i am fine !',
                                            isMe: false,
                                          ),
                                          Bubble(
                                            message: 'yes i\'ve seen the docs',
                                            isMe: false,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          width: MediaQuery.of(context).size.width,
                          bottom: MediaQuery.of(context).padding.bottom + 10,
                          left: 0,
                          child: Container(
                            width: double.infinity,
                            height: duSetHeight(50),
                            padding: EdgeInsets.symmetric(horizontal: duSetWidth(10)),
                            child: Container(
                              padding: EdgeInsets.only(left: duSetWidth(25)),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                color: HexColor('#BEDCFD')
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: 'Enter Message',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: duSetWidth(10)),
                                  Container(
                                    padding: EdgeInsets.only(right: duSetWidth(2)),
                                    width: duSetHeight(40),
                                    height: duSetWidth(40),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.white,
                                    ),
                                    child: InkWell(
                                      child: Center(
                                        child: Image.asset('assets/icon/send.png', width: duSetWidth(26), height: duSetHeight(26),),
                                      ),
                                      onTap: () {
                                        print('click');
                                      },
                                    ),
                                  ),
                                  SizedBox(width: duSetWidth(8)),
                                ],
                              ),
                            )
                          ),
                        ),
                        SizedBox(height: duSetHeight(10),)
                      ],
                    ),
                  )
                  //widget组件
                ],
              ),
            ),
          );
        });
  }

}