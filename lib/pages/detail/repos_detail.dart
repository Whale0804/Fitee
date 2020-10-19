import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReposDetailPage extends StatefulWidget {

  String fullName;

  ReposDetailPage({Key key, this.fullName}): super(key: key);

  @override
  _ReposDetailState createState()=> _ReposDetailState();
}


class _ReposDetailState extends State<ReposDetailPage> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AppBarWidget(
                title: widget.fullName,
                back: true,
              ),
              Expanded(
                child: Container(
                  color: Colors.amber,
                  child: Center(
                    child: Text(
                      widget.fullName,
                      style: TextStyle(
                        color: AppTheme.nearlyBlack,
                        fontSize: duSetFontSize(18)
                      ),
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