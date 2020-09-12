
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/widgets/drawer/drawer_custom.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {

  // drawer 宽度
  final double drawerWidth;
  // 按钮点击事件
  final Function(DrawerIndex) onCellClick;
  // 渲染的主页
  final Widget screenView;
  // 是否打开
  final Function(bool) drawerIsOpen;
  // 动画图标
  final AnimatedIconData animatedIconData;
  // 菜单视图
  final Widget menuView;
  // 当前主页index
  final DrawerIndex screenIndex;

  const DrawerWidget({Key key, this.drawerWidth = 250, this.onCellClick, this.screenView, this.drawerIsOpen, this.animatedIconData = AnimatedIcons.arrow_menu,
      this.menuView, this.screenIndex}): super(key: key);

  @override
  _DrawerWidgetState createState()=> _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> with TickerProviderStateMixin {

  ScrollController scrollController;
  AnimationController iconAnimationController;
  AnimationController animationController;

  double scrolloffset = 0.0;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    iconAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 0));
    iconAnimationController..animateTo(1.0, duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
    scrollController = ScrollController(initialScrollOffset: widget.drawerWidth);
    scrollController
      ..addListener(() {
        if (scrollController.offset <= 0) {
          if (scrolloffset != 1.0) {
            setState(() {
              scrolloffset = 1.0;
              try {
                widget.drawerIsOpen(true);
              } catch (_) {}
            });
          }
          iconAnimationController.animateTo(0.0, duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
        } else if (scrollController.offset > 0 && scrollController.offset < widget.drawerWidth.floor()) {
          iconAnimationController.animateTo((scrollController.offset * 100 / (widget.drawerWidth)) / 100,
              duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
        } else {
          if (scrolloffset != 0.0) {
            setState(() {
              scrolloffset = 0.0;
              try {
                widget.drawerIsOpen(false);
              } catch (_) {}
            });
          }
          iconAnimationController.animateTo(1.0, duration: const Duration(milliseconds: 0), curve: Curves.fastOutSlowIn);
        }
      });
    WidgetsBinding.instance.addPostFrameCallback((_) => getInitState());
    super.initState();
  }

  Future<bool> getInitState() async {
    scrollController.jumpTo(
      widget.drawerWidth,
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: ClampingScrollPhysics()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width + widget.drawerWidth,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: widget.drawerWidth,
                height: MediaQuery.of(context).size.height,
                child: AnimatedBuilder(
                  animation: iconAnimationController,
                  builder: (BuildContext context, Widget child){
                    return Transform(
                      transform: Matrix4.translationValues(scrollController.offset, 0.0, 0.0),
                      child: DrawerCustom(
                        screenIndex: widget.screenIndex == null ? DrawerIndex.HOME : widget.screenIndex,
                        iconAnimationController: iconAnimationController,
                        callBackIndex: (DrawerIndex index){
                          onDrawerClick();
                          try{
                            widget.onCellClick(index);
                          }catch (_) {}
                        },
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: AppTheme.grey.withOpacity(0.6), blurRadius: 24),
                    ]
                  ),
                  child: Stack(
                    children: <Widget>[
                      IgnorePointer(
                        ignoring: scrolloffset == 1.0 || false,
                        child: Scaffold(
                          backgroundColor: AppTheme.white,
                          body: FutureBuilder<bool>(
                            future: getData(),
                            builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
                              if(!snapshot.hasData) {
                                return SizedBox();
                              }else {
                                return Padding(
                                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                                  child: widget.screenView,
                                );
                              }
                            }
                          ),
                        ),
                      ),
                      if(scrolloffset == 1.0) InkWell(onTap: (){onDrawerClick();}),
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8, left: 8),
                        child: SizedBox(
                          width: AppBar().preferredSize.height - 8,
                          height: AppBar().preferredSize.height - 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
                              child: Center(
                                child: widget.menuView != null
                                ? widget.menuView
                                : AnimatedIcon(
                                  icon: widget.animatedIconData != null ? widget.animatedIconData : AnimatedIcons.arrow_menu,
                                  progress: iconAnimationController,
                                ),
                              ),
                              onTap: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                onDrawerClick();
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  void onDrawerClick() {
    //if scrollcontroller.offset != 0.0 then we set to closed the drawer(with animation to offset zero position) if is not 1 then open the drawer
    if (scrollController.offset != 0.0) {
      scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    } else {
      scrollController.animateTo(
        widget.drawerWidth,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}


