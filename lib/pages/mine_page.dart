
import 'package:fitee/model/user/user_provider.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MinePage extends StatefulWidget {

  @override
  _MinePageState createState()=> _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppBarWidget(
              title: '我 的',
              icon: Icon(Icons.settings),
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
                      shrinkWrap: true, // 关键
                      children: [
                        UserCard(context),
                        ReposCard(context),
                        const SizedBox(height: 60)
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

  Widget UserCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: duSetHeight(0),left: duSetWidth(16), right: duSetWidth(16), bottom: duSetHeight(15)),
      child: Consumer<UserProvider>(
        builder: (context, state, child) {
          return Container(
            padding: EdgeInsets.all(12),
            height: duSetHeight(180),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(16)),
                //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, -2.0), //阴影xy轴偏移量
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
                          Text(state.user != null ? state.user.bio : '一个程序员',
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
                                                color: HexColor('#829099'),
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
                                                color: HexColor('#829099'),
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
                                                color: HexColor('#829099'),
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
                SizedBox(height: duSetHeight(13)),
                Row(
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
                            onPressed: ()=> {},
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget ReposCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: duSetWidth(16), right: duSetWidth(16)),
      child: Container(
        width: double.infinity,
        height: duSetHeight(65),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SizedBox(),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: VerticalDivider(
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: SizedBox(),
            )
          ],
        ),
      ),
    );
  }

}