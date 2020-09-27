import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FiteeLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Container(
     width: double.infinity,
     height: double.infinity,
     child: Center(
       child: SizedBox(
         height: duSetHeight(100),
         width: duSetWidth(120),
         child: Card(
           color: AppTheme.dark_grey.withOpacity(.5),
           child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 Container(
                   width: 50.0,
                   height: 50.0,
                   child: SpinKitFadingCube(
                     color: Colors.white,
                     size: 25.0,
                   ),
                 ),
                 Container(
                   child: Text('拼命加载中',
                     style: TextStyle(
                         color: AppTheme.nearlyWhite,
                         fontSize: duSetFontSize(18)
                     ),
                   ),
                 )
               ]
           ),
         ),
       ),
     ),
   );
  }

}