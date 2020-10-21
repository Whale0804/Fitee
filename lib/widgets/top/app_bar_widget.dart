import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget {

  final String title;
  final Function callBack;
  final Icon icon;
  final Color color;
  final Color textColor;
  final Color iconColor;
  final bool back;
  final int status;

  AppBarWidget({Key key, this.title, this.callBack, this.icon, this.color, this.textColor, this.iconColor, this.back = false, this.status = 0}): super(key: key);

  @override
  _AppBarWidgetState createState()=> _AppBarWidgetState();

}

class _AppBarWidgetState extends State<AppBarWidget>{



  @override
  Widget build(BuildContext context) {
    return widget.back == true ? Container(
      color: widget.color ?? Colors.white,
      child: AppBar(
        brightness: widget.status == 0 ? Brightness.light : Brightness.dark,
        title: Text(widget.title,
          style: TextStyle(
              fontSize: duSetFontSize(18),
              color: widget.textColor ?? AppTheme.darkText,
              fontWeight: FontWeight.w700
          ),
        ),
        leading: InkWell(
          borderRadius:
          BorderRadius.circular(AppBar().preferredSize.height),
          child: Icon(Icons.arrow_back, color: widget.iconColor ?? Colors.black),
          onTap: ()=>{
            NavUtil.pop()
          },
        ),
        backgroundColor: widget.color ?? Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          InkWell(
            borderRadius:
            BorderRadius.circular(AppBar().preferredSize.height),
            child: widget.icon == null ? const SizedBox() : Icon(
              widget.icon.icon,
              color: AppTheme.dark_grey,
            ),
            onTap: () {
              widget.callBack();
            },
          ),
        ],
      ),
    ) :
    Container(
      color: widget.color ?? Colors.white,
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
                child: Text(widget.title,
                  style: TextStyle(
                    fontSize: duSetFontSize(18),
                    color: widget.textColor ?? AppTheme.darkText,
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
                  child: widget.icon == null ? const SizedBox() : Icon(
                    widget.icon.icon,
                    color: widget.iconColor ?? AppTheme.dark_grey,
                  ),
                  onTap: () {
                    widget.callBack();
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