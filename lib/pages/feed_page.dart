import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DiscoveryPage extends StatefulWidget {
  
  @override
  _DiscoveryPageState createState()=> _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {

  TabController _controller;
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 2,
      vsync: ScrollableState(),
    );
    _controller.addListener(() {
      setState(() {
        tabIndex = _controller.index;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppBarWidget(
              title: 'Feed'
            ),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // TabBar
                    Container(
                      width: double.infinity,
                      child: TabBar(
                        controller: _controller,
                        labelColor: AppTheme.darkText,
                        unselectedLabelColor: AppTheme.descText,
                        indicatorColor: Colors.transparent,
                        indicatorWeight: duSetHeight(1.0),
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w500
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontWeight: FontWeight.w400
                        ),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                //Tab(icon: Icon(Icons.local_florist)),
                                Image.asset("assets/icon/all_feed.png", width: duSetWidth(20), height: duSetHeight(20),
                                  color: tabIndex == 0 ? HexColor('#171717') : AppTheme.descText,
                                ),
                                const SizedBox(width: 12,),
                                Text('All Feed',
                                  style: TextStyle(
                                    fontSize: duSetFontSize(18),
                                    fontWeight: FontWeight.w400
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset("assets/icon/my_feed.png", width: duSetWidth(21), height: duSetHeight(21),
                                  color: tabIndex == 1 ? HexColor('#171717') : AppTheme.descText,
                                ),
                                const SizedBox(width: 12,),
                                Text('My Feed',
                                  style: TextStyle(
                                      fontSize: duSetFontSize(18),
                                      fontWeight: FontWeight.w400
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //TabView
                    Expanded(
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.only(top: 0,left: duSetWidth(16), right: duSetWidth(16)),
                          child: TabBarView(
                            controller: _controller,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: ListView(
                                      padding: EdgeInsets.only(top: duSetHeight(12)),
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(16)),
                                              //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey.withOpacity(.2),
                                                    offset: Offset(0.0, -1.0), //阴影xy轴偏移量
                                                    blurRadius: 30.0, //阴影模糊程度
                                                    spreadRadius: 1.0 //阴影扩散程度
                                                ),
                                              ]
                                          ),
                                          child: Consumer(),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: duSetHeight(65))
                                ],
                              ),
                              Icon(Icons.change_history, size: 128.0, color: Colors.black12),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
            ),
          ]
      ),
    );
  }
  
}