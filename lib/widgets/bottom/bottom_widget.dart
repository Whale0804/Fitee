
import 'package:flutter/material.dart';
import 'package:fitee/widgets/bottom/bottom_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'TabIconData.dart';

class BottomWidget extends StatefulWidget {

  List<TabIconData> tabIconList;
  Function(int index) navigationRoute;

  BottomWidget({Key key, this.tabIconList, this.navigationRoute}): super(key: key);

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> with TickerProviderStateMixin {

  AnimationController animationController;

  @override
  void initState() {
    widget.tabIconList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    widget.tabIconList[0].isSelected = true;
    animationController = AnimationController(
        duration: Duration(milliseconds: 600), vsync: this
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarWidget(
          tabIconsList: widget.tabIconList,
          onChangeIndex: (int index) {
            animationController.reverse().then<dynamic>((data) {
              if(!mounted) return;
              widget.navigationRoute(index);
            });
          },
          onAddClick: (){
            print("click add method");
          },
        ),
      ],
    );
  }
  
}