

import 'package:fitee/cache/local_storage.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/pages/login/teddy_controller.dart';
import 'package:fitee/plugin/toast.dart';
import 'package:fitee/route/base/base_route.dart';
import 'package:fitee/services/login_service.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/input/tracking_text_input.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {

  final bool enableArrow;
  LoginPage({Key key, this.enableArrow = false}): super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool pwdSwitch = false;
  GlobalKey _formKey = GlobalKey<FormState>();

  String _username = '';
  String _password = '';
  bool _isObscured = false;


  TeddyController _teddyController = TeddyController();


  _loginAction(BuildContext context) async {
    if ((_formKey.currentState as FormState).validate()) {
      try {
        var res = await LoginApi.login(username: _username, password: _password);
        if(res != null && res['access_token'] != null){
          LocalStorage.set(AppConfig.TOKEN_KEY, res['access_token']);
          LocalStorage.set(AppConfig.USER_NAME_KEY, _username);
          LocalStorage.set(AppConfig.USER_PASS_KEY, _password);
          LocalStorage.setBool(AppConfig.LOGIN_KEY, true);
          NavUtil.pushReplacement(BaseRoute(),context: context);
          Toast.toast(
            context,
            msg: '登录成功，欢迎回来～～～',
            showTime: 3000,
          );
        }
      }catch (e) {
        _teddyController.play('fail');
        Flushbar(
          messageText: Text("用户名或密码错误", style: TextStyle(
            fontSize: duSetFontSize(16),
            color: AppTheme.darkText
          ),),
          icon: Icon(
            Icons.dangerous,
            size: 28.0,
            color: AppTheme.darkText,
          ),
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(8),
          borderRadius: 8,
          backgroundColor: AppTheme.nearlyWhite,
        )..show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 根据iphone X 高度适配,高度去掉 顶部、底部
    ScreenUtil.init(context,
        width: 375, height: 812 - 44 - 34, allowFontScaling: true);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login/bg.png'),
              fit: BoxFit.cover
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: widget.enableArrow ? AppBar(
          leading: Icon(Icons.arrow_back),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ) : AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                padding: EdgeInsets.symmetric(horizontal: 24),
                width: double.infinity,
                child: FlareActor(
                  "assets/login/teddy.flr",
                  shouldClip: false,
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.contain,
                  controller: _teddyController,
                ),
              ),
              SizedBox(height: duSetHeight(7.8),),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.7),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: duSetHeight(24)),
                    Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TrackingTextInput(
                            enable: true,
                            hintText: '手机号/邮箱',
                            icon: Icons.account_circle,
                            onCaretMoved: (Offset caret) {
                              _teddyController.lookAt(caret);
                            },
                            onTextChanged: (String email) {
                              setState(() {
                                _username = email;
                              });
                            },
                          ),
                          SizedBox(height: duSetHeight(20)),
                          Container(
                            decoration: BoxDecoration(
                                color: HexColor('#EFEFEF'),
                                borderRadius: BorderRadius.all(Radius.circular(100))
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TrackingTextInput(
                                    enable: true,
                                    hintText: '密码',
                                    icon: Icons.offline_bolt,
                                    isObscured: _isObscured,
                                    onCaretMoved: (Offset caret) {
                                      _teddyController.lookAt(caret);
                                    },
                                    onTextChanged: (String password) {
                                      setState(() {
                                        _password = password;
                                      });
                                    },
                                  ),
                                ),
                                _password != '' ? IconButton(
                                  icon: Icon(
                                    _isObscured
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: _isObscured ? AppTheme.descText : Colors.blueAccent,
                                    size: duSetFontSize(18),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscured = !_isObscured;
                                      _teddyController.coverEyes(!_isObscured);
                                    });
                                  },
                                ) : SizedBox(),
                              ],
                            ),
                          ),
                          SizedBox(height: duSetHeight(10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: RichText(
                                    textAlign: TextAlign.right,
                                    text: TextSpan(text: "忘记密码? ", style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blueAccent,
                                    ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          //NavUtil.push()
                                        },
                                    )
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: duSetHeight(20)),
                          Container(
                            width: duSetWidth(150),
                            height: 50,
                            child: FlatButton(
                              colorBrightness: Brightness.dark,
                              shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                              onPressed: ()=> _loginAction(context),
                              child: Text(
                                "登 录",
                                style: TextStyle(
                                    fontSize: duSetFontSize(15),
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white
                                ),
                              ),
                              color: Colors.blueAccent,
                            ),
                          ),
//                                SizedBox(height: duSetHeight(20)),
//                                RichText(
//                                  text: TextSpan(
//                                  text: "没有账号? ",
//                                  style: TextStyle(
//                                    fontSize: 15,
//                                    fontWeight: FontWeight.w500,
//                                    color: Colors.white,
//                                  ),
//                                  children: [
//                                    TextSpan(
//                                      text: "去注册",
//                                      style: TextStyle(
//                                        fontSize: 15,
//                                        fontWeight: FontWeight.w600,
//                                        color: Colors.blueAccent,
//                                        decoration: TextDecoration.underline
//                                      ),
//                                      recognizer: TapGestureRecognizer()
//                                        ..onTap = () async {
//                                          NavUtil.push(RegisterPage(enableArrow: true));
//                                        },
//                                    ),]
//                                  )
//                                ),
                          SizedBox(height: duSetHeight(20))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}