import 'package:fitee/model/repository/file_entity.dart';
import 'package:fitee/model/repository/file_provider.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/store.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/loading/FiteeLoading.dart';
import 'package:fitee/widgets/markdown/markdown.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:fitee/widgets/webview/webview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class File extends StatefulWidget{

  String fullName;
  String sha;
  String title;

  File({Key key, this.fullName, this.sha, this.title}): super(key: key);

  _FileState createState()=> _FileState();
}

class _FileState extends State<File> with TickerProviderStateMixin {

  FileEntity file;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    await Store.value<FileProvider>(NavUtil.ctx).setClear();
    FileEntity data = await Store.value<FileProvider>(NavUtil.ctx).fetchFile(fullName: widget.fullName, sha: widget.sha);
    setState(() {
      file = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Store.connect<FileProvider>(builder: (context, state, child){
          return state.loading ? FiteeLoading() : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AppBarWidget(
                  title: widget.title,
                  back: true,
                ),
                Container(
                  width: double.infinity,
                  color: AppTheme.white,
                  padding: EdgeInsets.symmetric(horizontal: duSetWidth(18), vertical: duSetHeight(12)),
                  child: Store.connect<FileProvider>(builder: (context, state, child){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:<Widget>[
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              text: '..',
                              style: TextStyle(color: HexColor('#0079FA'), fontSize: duSetFontSize(18)),
                              recognizer: TapGestureRecognizer()..onTap = () async {
                                NavUtil.pop();
                              },
                            ),
                          ),
                        )
                      ] ,
                    );
                  }),
                ),
                Expanded(
                  child: Container(
                    color: AppTheme.white,
                    padding: EdgeInsets.symmetric(horizontal: duSetWidth(12)),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: duSetWidth(18), vertical: duSetHeight(12)),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          border: Border.all(color: HexColor('#0079FA'), width: 2)
                      ),
                      child: Markdown(
                        data: Utils.base64decode(file.content??=''),
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        syntaxHighlighter: FiteeHighlighter(),
                        onTapLink: (text, href, title) {
                          NavUtil.push(FiteeWebView(url: href));
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom,)
              ],
          );
        }),
      ),
    );
  }

}