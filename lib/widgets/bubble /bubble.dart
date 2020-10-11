import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/utils.dart';
import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {

  final bool isMe;
  final String message;

  Bubble({this.message, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      padding: isMe ? EdgeInsets.only(left: 40) : EdgeInsets.only(right: 40),
      child: Column(
        mainAxisAlignment:
        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: isMe
                  ? LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.1,
                    1
                  ],
                  colors: [
                    HexColor('#70C386'),
                    HexColor('#399864'),
                  ])
                  : LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.1,
                    1
                  ],
                  colors: [
                    Color(0xFFEBF5FC),
                    Color(0xFFEBF5FC),
                  ]),
              borderRadius: isMe
                  ? BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(0),
                bottomLeft: Radius.circular(15),
              )
                  : BorderRadius.only(
                topRight: Radius.circular(15),
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(0),
              ),
            ),
            child: Column(
              crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  message,
                  textAlign: isMe ? TextAlign.end : TextAlign.start,
                  style: TextStyle(
                    color: isMe ? Colors.white : AppTheme.descText,
                    fontSize: duSetFontSize(13)
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}