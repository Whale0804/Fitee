import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/loading/FiteeLoading.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FiteeWebView extends StatefulWidget {

  final String url;

  FiteeWebView({Key key, this.url}): super(key: key);

  @override
  _FiteeWebViewState createState()=> _FiteeWebViewState();
}

class _FiteeWebViewState extends State<FiteeWebView>{

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppBarWidget(
              title: widget.url,
              back: true,
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: WebView(
                      initialUrl: widget.url,
                      javascriptMode: JavascriptMode.unrestricted,
                      navigationDelegate: (NavigationRequest request) {
                        setState(() {
                          loading = true; // 开始访问页面，更新状态
                        });
                        return NavigationDecision.navigate;
                      },
                      onPageFinished: (String url) {
                        setState(() {
                          loading = false; // 页面加载完成，更新状态
                        });
                      },
                    ),
                  ),
                  loading ? FiteeLoading() : SizedBox(height: 0,width: 0)
                ],
              ),
            )
          ]
      ),
    );
  }

}