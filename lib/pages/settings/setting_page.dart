import 'package:fitee/pages/settings/work_page.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {

  _SettingPageState createState()=> _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  bool fingerprintEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppBarWidget(
            title: 'Setting',
            back: true,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              child: ListView(
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.only(top: duSetHeight(12)),
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: duSetWidth(12),bottom: duSetHeight(12)),
                        child: Text(
                          '系统',
                          style: TextStyle(
                            color: AppTheme.descText,
                            fontSize: duSetFontSize(18),
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      Divider( thickness: 1.2, height: 1.2, color: Colors.grey.withOpacity(.2)),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: duSetWidth(16),vertical: duSetHeight(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Icon(Icons.language, size: duSetFontSize(24)),
                            SizedBox(width: duSetWidth(12)),
                            Text(
                              '语言',
                              style: TextStyle(
                                fontSize: duSetFontSize(18),
                                fontWeight: FontWeight.w500,
                                color: AppTheme.darkText
                              ),
                            ),
                            SizedBox(width: duSetWidth(15)),
                            Expanded(
                              child: Text(
                                'English',
                                style: TextStyle(
                                  fontSize: duSetFontSize(16),
                                  color: AppTheme.descText,
                                  fontWeight: FontWeight.w500
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(width: duSetWidth(12)),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                      Divider( thickness: 1.2, height: 1.2, indent: duSetWidth(15), endIndent: duSetWidth(15), color: Colors.grey.withOpacity(.2)),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: duSetWidth(16),vertical: duSetHeight(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Image.asset("assets/icon/black_white.png", width: duSetWidth(24), height: duSetHeight(24),),
                            SizedBox(width: duSetWidth(12)),
                            Text(
                              '夜间模式',
                              style: TextStyle(
                                  fontSize: duSetFontSize(18),
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.darkText
                              ),
                            ),
                            SizedBox(width: duSetWidth(15)),
                            Expanded(
                              child: Text(
                                '跟随系统',
                                style: TextStyle(
                                    fontSize: duSetFontSize(16),
                                    color: AppTheme.descText,
                                    fontWeight: FontWeight.w500
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(width: duSetWidth(12),),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                      Divider( thickness: 1.2, height: 1.2, color: Colors.grey.withOpacity(.2)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: duSetWidth(12),bottom: duSetHeight(12),top: duSetHeight(24)),
                        child: Text(
                          '通用',
                          style: TextStyle(
                            color: AppTheme.descText,
                            fontSize: duSetFontSize(18),
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      Divider( thickness: 1.2, height: 1.2, color: Colors.grey.withOpacity(.2)),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: duSetWidth(16),vertical: duSetHeight(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Image.asset("assets/icon/storage.png", width: duSetWidth(22), height: duSetHeight(22),),
                            SizedBox(width: duSetWidth(12)),
                            Text(
                              '清空缓存',
                              style: TextStyle(
                                fontSize: duSetFontSize(18),
                                fontWeight: FontWeight.w500,
                                color: AppTheme.darkText
                              ),
                            ),
                            SizedBox(width: duSetWidth(15)),
                            Expanded(
                              child: Text(
                                '29.5M',
                                style: TextStyle(
                                  fontSize: duSetFontSize(16),
                                  color: AppTheme.descText,
                                  fontWeight: FontWeight.w500
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                            SizedBox(width: duSetWidth(12)),
                          ],
                        ),
                      ),
                      Divider( thickness: 1.2, height: 1.2, indent: duSetWidth(15), endIndent: duSetWidth(15), color: Colors.grey.withOpacity(.2)),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: duSetWidth(16),vertical: duSetHeight(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Image.asset("assets/icon/fingerprint.png", width: duSetWidth(22), height: duSetHeight(22),),
                            SizedBox(width: duSetWidth(12)),
                            Text(
                              '开启指纹',
                              style: TextStyle(
                                  fontSize: duSetFontSize(18),
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.darkText
                              ),
                            ),
                            SizedBox(width: duSetWidth(15)),
                            Expanded(
                              child: SizedBox(),
                            ),
                            Switch(
                              value: this.fingerprintEnable,
                              activeColor: AppTheme.descText,     // 激活时原点颜色
                              activeTrackColor: HexColor('#171717'),
                              onChanged: (value) {
                                this.setState(() {
                                  this.fingerprintEnable = !this.fingerprintEnable;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Divider( thickness: 1.2, height: 1.2, indent: duSetWidth(15), endIndent: duSetWidth(15), color: Colors.grey.withOpacity(.2)),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: duSetWidth(16),vertical: duSetHeight(16)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Image.asset("assets/icon/open_source.png", width: duSetWidth(24), height: duSetHeight(24),),
                            SizedBox(width: duSetWidth(12)),
                            Text(
                              '开源协议',
                              style: TextStyle(
                                  fontSize: duSetFontSize(18),
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.darkText
                              ),
                            ),
                            SizedBox(width: duSetWidth(15)),
                            Expanded(
                              child: const SizedBox(),
                            ),
                            SizedBox(width: duSetWidth(12),),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                      Divider( thickness: 1.2, height: 1.2, color: Colors.grey.withOpacity(.2)),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(left: duSetWidth(12),bottom: duSetHeight(12),top: duSetHeight(24)),
                        child: Text(
                          '其他',
                          style: TextStyle(
                            color: AppTheme.descText,
                            fontSize: duSetFontSize(18),
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ),
                      Divider( thickness: 1.2, height: 1.2, color: Colors.grey.withOpacity(.2)),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: duSetWidth(16),vertical: duSetHeight(16)),
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Image.asset("assets/icon/teamwork.png", width: duSetWidth(22), height: duSetHeight(22),),
                              SizedBox(width: duSetWidth(12)),
                              Text(
                                '外包合作',
                                style: TextStyle(
                                    fontSize: duSetFontSize(18),
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.darkText
                                ),
                              ),
                              SizedBox(width: duSetWidth(15)),
                              Expanded(
                                child: SizedBox()
                              ),
                              SizedBox(width: duSetWidth(12)),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        ),
                        onTap: (){
                          NavUtil.push(WorkPage());
                        },
                      ),
                      Divider( thickness: 1.2, height: 1.2, color: Colors.grey.withOpacity(.2)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]
      )
    );
  }
}