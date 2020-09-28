import 'package:fitee/main.dart';
import 'package:fitee/model/event/event.dart';
import 'package:fitee/model/event/event_provider.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/loading/FiteeLoading.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class DiscoveryPage extends StatefulWidget {
  
  @override
  _DiscoveryPageState createState()=> _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {

  TabController _controller;
  int tabIndex = 0;
  int page = 1;

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
    return ChangeNotifierProvider(
        create: (_) => EventProvider(),
        child: Container(
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
                          child: TabBarView(
                            controller: _controller,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Consumer<EventProvider>(builder: (context, state, child){
                                      return state.loading ?
                                      FiteeLoading() :
                                      EasyRefresh.custom(
                                        emptyWidget: state.result.length == 0 ? Container(
                                          color: Colors.white,
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Center(
                                            child: Image.asset('assets/state/empty_list.png'),
                                          ),
                                        ) : null,
                                        header: BezierHourGlassHeader(
                                          backgroundColor: Colors.transparent,
                                          color: AppTheme.dismissibleBackground,
                                        ),
                                        footer: TaurusFooter(
                                          backgroundColor: AppTheme.dismissibleBackground
                                        ),
                                        onRefresh: () async{
                                          setState(() {
                                            page = 1;
                                          });
                                          var eventProvider = Provider.of<EventProvider>(context, listen: false);
                                          eventProvider.setPage(page: page);
                                        },
                                        onLoad: () async {
                                          setState(() {
                                            page++;
                                          });
                                          var eventProvider = Provider.of<EventProvider>(context, listen: false);
                                          eventProvider.setPage(page: page);
                                        },
                                        slivers: <Widget>[
                                          AnimationLimiter(
                                            child: SliverList(delegate: SliverChildBuilderDelegate(
                                                    (context, index) {
                                                  Event event = state.result[index];
                                                  return Padding(
                                                    padding: EdgeInsets.only(top: duSetHeight(12), left: duSetWidth(16), right: duSetWidth(16)),
                                                    child: AnimationConfiguration.staggeredList(
                                                      position: index,
                                                      duration: const Duration(milliseconds: 475),
                                                      child: SlideAnimation(
                                                        verticalOffset: 50.0,
                                                        child: FadeInAnimation(
                                                          child: Container(
                                                            width: double.infinity,
                                                            height: 100,
                                                            margin: EdgeInsets.only(bottom: duSetHeight(12)),
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
                                                            child: Text(event.id.toString()),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                childCount: state.result.length
                                            )),
                                          )
                                        ],
                                      );
                                    }
                                    ),
                                  ),
                                  SizedBox(height: duSetHeight(75))
                                ],
                              ),
                              Icon(Icons.change_history, size: 128.0, color: Colors.black12),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]
          ),
        )
      );
  }
  
}