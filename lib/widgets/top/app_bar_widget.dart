import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget{

  final String title;
  final Function callBack;
  final Icon icon;
  final Color color;
  final bool back;

  AppBarWidget({Key key, this.title, this.callBack, this.icon, this.color, this.back = false}): super(key: key);

  @override
  Widget build(BuildContext context) {
    print(this.back);
    return back == true ? Container(
      color: Colors.white,
      child: AppBar(
        title: Text(title,
          style: TextStyle(
              fontSize: duSetFontSize(18),
              color: AppTheme.darkText,
              fontWeight: FontWeight.w700
          ),
        ),
        leading: InkWell(
          borderRadius:
          BorderRadius.circular(AppBar().preferredSize.height),
          child: Icon(Icons.arrow_back, color: Colors.black),
          onTap: ()=>{
            NavUtil.pop()
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          InkWell(
            borderRadius:
            BorderRadius.circular(AppBar().preferredSize.height),
            child: icon == null ? const SizedBox() : Icon(
              icon.icon,
              color: AppTheme.dark_grey,
            ),
            onTap: () {
              callBack();
            },
          ),
        ],
      ),
    ) :
    Container(
      color: color == null ? Colors.white : color,
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            )
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 1),
                child: Text(title,
                  style: TextStyle(
                    fontSize: duSetFontSize(18),
                    color: AppTheme.darkText,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                  BorderRadius.circular(AppBar().preferredSize.height),
                  child: icon == null ? const SizedBox() : Icon(
                    icon.icon,
                    color: AppTheme.dark_grey,
                  ),
                  onTap: () {
                   callBack();
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}