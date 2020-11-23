
import 'package:fitee/model/repository/file_provider.dart';
import 'package:fitee/model/repository/file_tree.dart';
import 'package:fitee/pages/file/file.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/store.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/loading/FiteeLoading.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Tree extends StatefulWidget {

  final FileTree file;
  final String fullName;
  final String ref;

  Tree({Key key, this.file, this.fullName, this.ref}): super(key: key);

  _TreeState createState() => _TreeState();
}

class _TreeState extends State<Tree> with TickerProviderStateMixin {

  List<FileTree> trees;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    await Store.value<FileProvider>(NavUtil.ctx).setClear();
    List<FileTree> list = await Store.value<FileProvider>(NavUtil.ctx).fetchTree(fullName: widget.fullName, sha: widget.file.sha);
    setState(() {
      trees = list;
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
                  title: widget.file.path,
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
                    child: Store.connect<FileProvider>(builder:(context, state, child) {
                      return Container(
                        color: AppTheme.white,
                        padding: EdgeInsets.symmetric(horizontal: duSetWidth(12)),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: duSetWidth(18), vertical: duSetHeight(12)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              border: Border.all(color: HexColor('#0079FA'), width: 2)
                          ),
                          child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: ListView.builder(
                                physics: ClampingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  FileTree ft = trees[index];
                                  return GestureDetector(
                                    onTap: () async {
                                      if(ft.type == 'tree'){
                                        NavUtil.push(Tree(file: ft, fullName: widget.fullName, ref: ft.sha));
                                      }else {
                                        NavUtil.push(File(fullName: widget.fullName, sha: ft.sha, title: ft.path));
                                      }
                                    },
                                    child: Container(
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
                                    ),
                                  );
                                },
                                itemCount: trees.length
                            ),
                          ),
                        ),
                      );
                    })
                ),
                SizedBox(height: MediaQuery.of(context).padding.bottom,)
              ]
          );
        }),
      ),
    );
  }
}