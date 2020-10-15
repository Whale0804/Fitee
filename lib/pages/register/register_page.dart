
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterPage extends StatefulWidget {

  final bool enableArrow;
  RegisterPage({Key key, this.enableArrow = false}): super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool pwdSwitch = false;
  GlobalKey _formKey = GlobalKey<FormState>();
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _mailController = TextEditingController();

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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: ()=>NavUtil.pop(),
          ),
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
                          SizedBox(height: duSetHeight(70)),
                          Form(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.disabled,
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
                                    hintText: '手机号',
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
                                SizedBox(height: duSetHeight(20)),
                                TextFormField(
                                  controller: _mailController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email, color: Colors.blueAccent,),
                                    filled: true,
                                    fillColor: HexColor('#EFEFEF'),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0x00FF0000)),
                                        borderRadius: BorderRadius.all(Radius.circular(100))),
                                    hintText: '邮箱',
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Color(0x00000000)),
                                        borderRadius: BorderRadius.all(Radius.circular(100))),
                                  ),
                                ),
                                SizedBox(height: duSetHeight(20)),
                                Container(
                                  width: duSetWidth(150),
                                  height: 50,
                                  child: FlatButton(
                                    colorBrightness: Brightness.dark,
                                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                                    onPressed: () {},
                                    child: Text(
                                      "注 册",
                                      style: TextStyle(
                                          fontSize: duSetFontSize(15),
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white
                                      ),
                                    ),
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                SizedBox(height: duSetHeight(20)),
                                RichText(
                                  text: TextSpan(
                                  text: "已有账号? ",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "去登录",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blueAccent,
                                        decoration: TextDecoration.underline
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async => NavUtil.pop(),
                                    ),]
                                  )
                                ),
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