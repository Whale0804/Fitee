
import 'package:fitee/cache/local_storage.dart';
import 'package:fitee/config/config.dart';
import 'package:fitee/plugin/toast.dart';
import 'package:fitee/route/base/base_route.dart';
import 'package:fitee/services/login_service.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/utils.dart';
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
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  _loginAction(BuildContext context) async {
    if ((_formKey.currentState as FormState).validate()) {
      var res = await LoginApi.login(username: _unameController.text, password: _pwdController.text);
      if(res != null && res['access_token'] != null){
        LocalStorage.set(AppConfig.TOKEN_KEY, res['access_token']);
        LocalStorage.set(AppConfig.USER_NAME_KEY, _unameController.text);
        LocalStorage.set(AppConfig.USER_PASS_KEY, _pwdController.text);
        LocalStorage.setBool(AppConfig.LOGIN_KEY, true);
        NavUtil.pushReplacement(BaseRoute(),context: context);
        Toast.toast(
          context,
          msg: '登录成功，欢迎回来～～～',
          showTime: 3000,
        );
      }else {
        Toast.toast(
          context,
          msg: '用户名或密码错误',
          showTime: 3000,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    /// 根据iphone X 高度适配,高度去掉 顶部、底部
    ScreenUtil.init(context,
        width: 375, height: 812 - 44 - 34, allowFontScaling: true);
    _unameController.addListener(() {
      setState(() {});
    });
    _pwdController.addListener(() {
      setState(() {});
    });
    return Container(
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
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: duSetHeight(160)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
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
                          SizedBox(height: duSetHeight(80)),
                          Form(
                            key: _formKey,
                            autovalidate: false,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                TextFormField(
                                  controller: _unameController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.account_circle, color: Colors.blueAccent,),
                                    filled: true,
                                    fillColor: HexColor('#EFEFEF'),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0x00FF0000)),
                                        borderRadius: BorderRadius.all(Radius.circular(100))),
                                    hintText: '手机号/邮箱',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0x00000000)),
                                        borderRadius: BorderRadius.all(Radius.circular(100))),
                                  ),
                                ),
                                SizedBox(height: duSetHeight(20)),
                                TextFormField(
                                  controller: _pwdController,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.offline_bolt, color: Colors.blueAccent,),
                                    filled: true,
                                    fillColor: HexColor('#EFEFEF'),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0x00FF0000)),
                                        borderRadius: BorderRadius.all(Radius.circular(100))),
                                    hintText: '密码',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0x00000000)),
                                        borderRadius: BorderRadius.all(Radius.circular(100))),
                                    suffixIcon: _pwdController.text != '' ? GestureDetector(
                                      onTap: () => setState(()=> pwdSwitch = !pwdSwitch),
                                      child: Icon(Icons.remove_red_eye, size: duSetHeight(20), color: pwdSwitch ? Colors.blueAccent : Colors.blueGrey.withOpacity(.5)),
                                    ) : SizedBox()
                                  ),
                                  obscureText: !pwdSwitch,
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
                  )
                ],
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: duSetHeight(70)),
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: AppTheme.grey.withOpacity(0.6), offset: const Offset(2.0, 4.0), blurRadius: 8.0),
                        ]
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all((Radius.circular(75.0))),
                      child: Image.asset('assets/daniel.jpg'),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}