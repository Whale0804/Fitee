import 'dart:math' as math;
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/bottom/TabIconData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomBarWidget extends StatefulWidget {

  final Function(int index) onChangeIndex;
  final Function onAddClick;
  final List<TabIconData> tabIconsList;


  BottomBarWidget({Key key, this.onChangeIndex, this.onAddClick, this.tabIconsList}): super(key: key);

  @override
  _BottomBarWidgetState createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> with TickerProviderStateMixin{

  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(duration: Duration(milliseconds: 1000), vsync: this);
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget child){
            return Transform(
              transform: Matrix4.translationValues(0, 0, 0),
              child: PhysicalShape(
                //背景颜色
                color: Colors.white,
                //设置垂直高度
                elevation: 16,
                //设置边缘剪切形状
                clipper: TabClipper(
                  radius: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animationController,curve: Curves.fastOutSlowIn))
                      .value * 32.0
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 52,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TabIcon(
                                tabIconData: widget.tabIconsList[0],
                                removeAllSelect: (){
                                  setRemoveAllSelection(widget.tabIconsList[0]);
                                  widget.onChangeIndex(0);
                                },
                              ),
                            ),
                            Expanded(
                              child: TabIcon(
                                tabIconData: widget.tabIconsList[1],
                                removeAllSelect: (){
                                  setRemoveAllSelection(widget.tabIconsList[1]);
                                  widget.onChangeIndex(1);
                                },
                              ),
                            ),
                            SizedBox(
                              width: Tween<double>(begin: 0.0, end: 1.0)
                                  .animate(CurvedAnimation(
                                  parent: animationController,
                                  curve: Curves.fastOutSlowIn))
                                  .value *
                                  64.0,
                            ),
                            Expanded(
                              child: TabIcon(
                                tabIconData: widget.tabIconsList[2],
                                removeAllSelect: (){
                                  setRemoveAllSelection(widget.tabIconsList[2]);
                                  widget.onChangeIndex(2);
                                },
                              ),
                            ),
                            Expanded(
                              child: TabIcon(
                                tabIconData: widget.tabIconsList[3],
                                removeAllSelect: (){
                                  setRemoveAllSelection(widget.tabIconsList[3]);
                                  widget.onChangeIndex(3);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
                ),
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
          child: SizedBox(
            width: 32 * 2.0,
            height: 32 + 52.0,
            child: Container(
              alignment: Alignment.topCenter,
              color: Colors.transparent,
              child: SizedBox(
                width: 32 * 2.0,
                height: 32 * 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animationController,
                      curve: Curves.fastOutSlowIn
                    )),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[100],
                        gradient: LinearGradient(
                          colors: [
                            Colors.lightBlue[100],
                            HexColor('#aac7d5')
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight
                        ),
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.lightBlue[100].withOpacity(.23),
                            offset: const Offset(4.0, 12.0),
                            blurRadius: 12.0
                          )
                        ]
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.white.withOpacity(.1),
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          onTap: () {
                            widget.onAddClick();
                          },
                          child: Icon(Icons.add, color: Colors.white, size: 30),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void setRemoveAllSelection(TabIconData tabIconData) {
    if (!mounted) return;
    setState(() {
      widget.tabIconsList.forEach((TabIconData tab) {
        tab.isSelected = false;
        if (tabIconData.index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }
}

class TabIcon extends StatefulWidget {

  final TabIconData tabIconData;
  final Function removeAllSelect;

  TabIcon({Key key, this.tabIconData, this.removeAllSelect}): super(key: key);

  @override
  _TabIconState createState()=> _TabIconState();
}

class _TabIconState extends State<TabIcon> with TickerProviderStateMixin{

  @override
  void initState() {
    widget.tabIconData.animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400))
    ..addStatusListener((status) {
      if(status == AnimationStatus.completed){
        if(!mounted) return;
        widget.removeAllSelect();
        widget.tabIconData.animationController.reverse();
      }
    });
    super.initState();
  }

  setAnimation() {
    widget.tabIconData.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    //AspectRatio组件是固定宽高比的组件，如果组件的宽度固定，希望高是宽的1/2
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        //InkWell 水波纹
        child: InkWell(
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onTap: () {
            if(!widget.tabIconData.isSelected){
              setAnimation();
            }
          },
          //IgnorePointer禁止用户输入的控件
          child: IgnorePointer(
             child: Stack(
               alignment: AlignmentDirectional.center,
               children: <Widget>[
                 ScaleTransition(
                   alignment: Alignment.center,
                   scale: Tween<double>(begin: 0.88, end: 1.0).animate(CurvedAnimation(parent: widget.tabIconData.animationController,
                      curve: Interval(0.1, 1.0, curve: Curves.fastOutSlowIn))),
                   child: Image.asset(widget.tabIconData.isSelected
                   ? widget.tabIconData.selectImagePath
                   : widget.tabIconData.imagePath,width: duSetWidth(30), height: duSetHeight(30)),
                 ),
                 Positioned(
                   top: 0,
                   left: 24,
                   right: 0,
                   child: ScaleTransition(
                     alignment: Alignment.center,
                     scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: widget.tabIconData.animationController,
                        curve: Interval(0.2, 1.0, curve: Curves.fastOutSlowIn))),
                     child: Container(
                       width: 8,
                       height: 8,
                       decoration: BoxDecoration(
                         color: HexColor('#59A8F8'),
                         shape: BoxShape.circle,
                       ),
                     ),
                   ),
                 ),
                 Positioned(
                   top: 0,
                   left: 10,
                   bottom: 8,
                   child: ScaleTransition(
                     alignment: Alignment.center,
                     scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: widget.tabIconData.animationController,
                        curve: Interval(0.5, 0.8, curve: Curves.fastOutSlowIn))),
                     child: Container(
                       width: 5,
                       height: 5,
                       decoration: BoxDecoration(
                         color: HexColor('#59A8F8'),
                         shape: BoxShape.circle
                       ),
                     ),
                   ),
                 ),
                 Positioned(
                   top: 6,
                   right: 5,
                   bottom: 0,
                   child: ScaleTransition(
                     alignment: Alignment.center,
                     scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: widget.tabIconData.animationController,
                        curve: Interval(0.5, 0.6, curve: Curves.fastOutSlowIn))),
                     child: Container(
                       width: 6,
                       height: 6,
                       decoration: BoxDecoration(
                         color: HexColor('#59A8F8'),
                         shape: BoxShape.circle
                       ),
                     ),
                   ),
                 )
               ],
             ),
          ),
        ),
      ),
    );
  }

}

class TabClipper extends CustomClipper<Path> {

  final double radius;

  TabClipper({this.radius = 32.0});

  @override
  Path getClip(Size size) {
    final Path path = new Path();

    final double v = 2 * radius;
    path.lineTo(0, 0);
    path.arcTo(Rect.fromLTWH(0, 0, radius, radius), degreeToRadians(180),
        degreeToRadians(90), false);
    path.arcTo(
        Rect.fromLTWH(
            ((size.width / 2) - v / 2) - radius + v * 0.04, 0, radius, radius),
        degreeToRadians(270),
        degreeToRadians(70),
        false);

    path.arcTo(Rect.fromLTWH((size.width / 2) - v / 2, -v / 2, v, v),
        degreeToRadians(160), degreeToRadians(-140), false);

    path.arcTo(
        Rect.fromLTWH((size.width - ((size.width / 2) - v / 2)) - v * 0.04, 0,
            radius, radius),
        degreeToRadians(200),
        degreeToRadians(70),
        false);
    path.arcTo(Rect.fromLTWH(size.width - radius, 0, radius, radius),
        degreeToRadians(270), degreeToRadians(90), false);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

  double degreeToRadians(double degree) {
    final double redian = (math.pi / 180) * degree;
    return redian;
  }

}