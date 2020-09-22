import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/screen.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget{

  final String title;
  final Function callBack;
  final Icon icon;

  AppBarWidget({Key key, this.title, this.callBack, this.icon}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
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