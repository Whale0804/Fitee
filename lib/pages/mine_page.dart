import 'package:fitee/cache/local_storage.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/model/user/user_provider.dart';
import 'package:fitee/pages/about/about_page.dart';
import 'package:fitee/pages/settings/setting_page.dart';
import 'package:fitee/plugin/toast.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MinePage extends StatefulWidget {
  final bool isCurrent;
  final bool back;

  MinePage({Key key, this.isCurrent = true, this.back = false}): super(key: key);

  @override
  _MinePageState createState()=> _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppBarWidget(
              title: '我 的',
              icon: Icon(Icons.settings),
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: state.user != null ? Image.network(state.user.avatar_url, width: 110,height: 110) : Image.asset('assets/daniel.jpg', width: 110,height: 110),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(state.user != null ? state.user.name : 'Fitee',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: duSetFontSize(24),
                                fontWeight: FontWeight.w600
                            ),
                            textAlign: TextAlign.left,
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
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            onPressed: () async {
                              print(await LocalStorage.get(AppConfig.TOKEN_KEY));
                            },
                            child: Text(
                              "私 信",
                              style: TextStyle(
                                  fontSize: duSetFontSize(15),
                                  fontWeight: FontWeight.w500,
                                  color: HexColor('#607383')
                              ),
                            ),
                            color: Colors.white,
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
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            onPressed: ()=> {},
                            child: Text(
                              "关 注",
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
                _Divider(),
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
                  _Divider(),
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
                  _Divider(),
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
                  _Divider(),
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
              _Divider(),
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
  Widget _Divider() {
    return Divider(
      height: 1.2,
      indent: 12,
      endIndent: 12,
      thickness: 1.2,
      color: Colors.grey.withOpacity(.2),
    );
  }
}