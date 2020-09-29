import 'package:fitee/config/config.dart';
import 'package:fitee/config/event_type.dart';
import 'package:fitee/model/event/event.dart';
import 'package:fitee/model/event/event_provider.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/relative_date_format.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/store.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/loading/FiteeLoading.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

class EventPage extends StatefulWidget {
  
  @override
  _EventPageState createState()=> _EventPageState();
}

class _EventPageState extends State<EventPage> {

  EventProvider eventProvider;
  TabController _controller;

  int tabIndex = 0;
  int page = 1;

  @override
  void initState() {
    super.initState();
    eventProvider = Store.value<EventProvider>(NavUtil.ctx);
    _controller = TabController(
      length: 2,
      vsync: ScrollableState(),
    );
    _controller.addListener(() {
      setState(() {
        tabIndex = _controller.index;
        page = 1;
        _initData(eventProvider);
      });
    });
    _initData(eventProvider);
  }

  _initData(EventProvider eventProvider) async {
    if(tabIndex == 0) {
      await eventProvider.fetchAllEvent();
    }else {
      await eventProvider.fetchMyEvent();
    }

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
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
                child: TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    _AllEventList(context: context),
                    _MyEventList(context: context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  /// 全部事件列表
  _AllEventList({BuildContext context}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: duSetHeight(6)),
        Expanded(
          child: Store.connect<EventProvider>(builder: (context, state, child){
            return state.allLoading ?
            FiteeLoading() :
            EasyRefresh.custom(
              emptyWidget: state.allResult.length == 0 ? Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Image.asset('assets/state/empty_list.png'),
                ),
              ) : null,
              header: TaurusHeader(
                backgroundColor: AppTheme.dismissibleBackground,
                completeDuration: Duration(milliseconds: 1200)
              ),
              // footer: TaurusFooter(
              //     backgroundColor: AppTheme.dismissibleBackground
              // ),
              onRefresh: () async{
                setState(() {
                  page = 1;
                });
                var eventProvider = Provider.of<EventProvider>(context, listen: false);
                eventProvider.setAllPage(page: page);
              },
              onLoad: () async {
                setState(() {
                  page++;
                });
                var eventProvider = Provider.of<EventProvider>(context, listen: false);
                eventProvider.setAllPage(page: page);
              },
              slivers: <Widget>[
                AnimationLimiter(
                  child: SliverList(delegate: SliverChildBuilderDelegate((context, index) {
                        Event event = state.allResult[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              top: duSetHeight(index == 0 ? 12: 0),
                              left: duSetWidth(16),
                              right: duSetWidth(16)
                          ),
                          child: AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 475),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: _EventItem(event: event),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: state.allResult.length
                    )
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((content, index) {
                    return Container(
                      height: duSetHeight(50),
                      color: Colors.transparent,
                    );
                  }, childCount: 1),
                ),
              ],
            );
          }
          ),
        ),
      ],
    );
  }
  _MyEventList({BuildContext context}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: duSetHeight(6)),
        Expanded(
          child: Consumer<EventProvider>(builder: (context, state, child){
            return state.myLoading ?
            FiteeLoading() :
            EasyRefresh.custom(
              emptyWidget: state.myResult.length == 0 ? Container(
                color: Colors.white,
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: Image.asset('assets/state/empty_list.png'),
                ),
              ) : null,
              header: TaurusHeader(
                backgroundColor: AppTheme.dismissibleBackground,
                completeDuration: Duration(milliseconds: 1200)
              ),
              // footer: TaurusFooter(
              //     backgroundColor: AppTheme.dismissibleBackground
              // ),
              onRefresh: () async{
                setState(() {
                  page = 1;
                });
                var eventProvider = Provider.of<EventProvider>(context, listen: false);
                eventProvider.setMyPage(page: page);
              },
              onLoad: () async {
                setState(() {
                  page++;
                });
                var eventProvider = Provider.of<EventProvider>(context, listen: false);
                eventProvider.setMyPage(page: page);
              },
              slivers: <Widget>[
                AnimationLimiter(
                  child: SliverList(delegate: SliverChildBuilderDelegate((context, index) {
                        Event event = state.myResult[index];
                        return Padding(
                          padding: EdgeInsets.only(top: duSetHeight(index == 0 ? 12: 0), left: duSetWidth(16), right: duSetWidth(16)),
                          child: AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 475),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: _EventItem(event: event),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: state.myResult.length
                  )),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((content, index) {
                    return Container(
                      height: duSetHeight(50),
                      color: Colors.transparent,
                    );
                  }, childCount: 1),
                ),
              ],
            );
          }
          ),
        ),
      ],
    );
  }
  /// 事件项
  _EventItem({Event event}) {
    if(event.type == EventType.PUSH_EVENT){
      return Container(
        margin: EdgeInsets.only(bottom: duSetHeight(10)),
        padding: EdgeInsets.all(duSetFontSize(12)),
        width: double.infinity,
        decoration: BoxDecoration(
            color: HexColor('#FAFDFC'),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.16),
                  blurRadius: 15.0, //阴影模糊程度
                  spreadRadius: 0.5 //阴影扩散程度
              ),
            ]
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _AvatarWidget(url: event.actor.avatar_url),
              SizedBox(width: duSetWidth(12),),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(event.actor.name,
                      style: TextStyle(
                          color: HexColor('#6B9BF2'),
                          fontSize: duSetFontSize(AppConfig.EVENT_NAME_SIZE),
                          fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: duSetHeight(6)),
                    Text(RelativeDateFormat.format(event.createdAt),
                      style: TextStyle(
                          color: AppTheme.descText,
                          fontSize: duSetFontSize(AppConfig.EVENT_TIME_SIZE),
                          fontWeight: FontWeight.w400
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: duSetHeight(6)),
                    Container(
                      width: double.infinity,
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE),
                              color: AppTheme.darkText,
                            ),
                            children: <InlineSpan>[
                              TextSpan(text: '推送到了'),
                              TextSpan(text: ' ' + event.repo.humanName + ' ', style: TextStyle(
                                color: HexColor('#6B9BF2'),
                                fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                              )),
                              TextSpan(text: '的'),
                              TextSpan(text: ' ' + event.payload.ref + ' '),
                              TextSpan(text: '分支'),
                            ]),
                      ),
                    ),
                  ],
                ),
              )
            ],
        ),
      );
    } else if(event.type == EventType.CREATE_EVENT){
      return Container(
        margin: EdgeInsets.only(bottom: duSetHeight(10)),
        padding: EdgeInsets.all(duSetFontSize(12)),
        width: double.infinity,
        decoration: BoxDecoration(
            color: HexColor('#FAFDFC'),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.16),
                  blurRadius: 15.0, //阴影模糊程度
                  spreadRadius: 0.5 //阴影扩散程度
              ),
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _AvatarWidget(url: event.actor.avatar_url),
            SizedBox(width: duSetWidth(12),),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(event.actor.name,
                    style: TextStyle(
                        color: HexColor('#6B9BF2'),
                        fontSize: duSetFontSize(AppConfig.EVENT_NAME_SIZE),
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Text(RelativeDateFormat.format(event.createdAt),
                    style: TextStyle(
                        color: AppTheme.descText,
                        fontSize: duSetFontSize(AppConfig.EVENT_TIME_SIZE),
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Container(
                    width: double.infinity,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          style: TextStyle(
                            fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE),
                            color: AppTheme.darkText,
                          ),
                          children: <InlineSpan>[
                            TextSpan(text: '创建了一个新的仓库'),
                            TextSpan(text: ' ' + event.repo.humanName + ' ', style: TextStyle(
                                color: HexColor('#6B9BF2'),
                                fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                            )),
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else if(event.type == EventType.PROJECT_COMMENT_EVENT){
      return Container(
        margin: EdgeInsets.only(bottom: duSetHeight(10)),
        padding: EdgeInsets.all(duSetFontSize(12)),
        width: double.infinity,
        decoration: BoxDecoration(
            color: HexColor('#FAFDFC'),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.16),
                  blurRadius: 15.0, //阴影模糊程度
                  spreadRadius: 0.5 //阴影扩散程度
              ),
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _AvatarWidget(url: event.actor.avatar_url),
            SizedBox(width: duSetWidth(12),),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(event.actor.name,
                    style: TextStyle(
                        color: HexColor('#6B9BF2'),
                        fontSize: duSetFontSize(AppConfig.EVENT_NAME_SIZE),
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Text(RelativeDateFormat.format(event.createdAt),
                    style: TextStyle(
                        color: AppTheme.descText,
                        fontSize: duSetFontSize(AppConfig.EVENT_TIME_SIZE),
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Container(
                    width: double.infinity,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          style: TextStyle(
                            fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE),
                            color: AppTheme.darkText,
                          ),
                          children: <InlineSpan>[
                            TextSpan(text: '发表了对'),
                            TextSpan(text: ' ' + event.repo.humanName + ' ', style: TextStyle(
                                color: HexColor('#6B9BF2'),
                                fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                            )),
                            TextSpan(text: '仓库的评论:'),
                            TextSpan(text: ' ' + event.payload.comment.body + ' ', style: TextStyle(
                                color: AppTheme.dark_grey,
                                fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                            )),
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else if(event.type == EventType.WATCH_EVENT){
      return Container(
        margin: EdgeInsets.only(bottom: duSetHeight(10)),
        padding: EdgeInsets.all(duSetFontSize(12)),
        width: double.infinity,
        decoration: BoxDecoration(
            color: HexColor('#FAFDFC'),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.16),
                  blurRadius: 15.0, //阴影模糊程度
                  spreadRadius: 0.5 //阴影扩散程度
              ),
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _AvatarWidget(url: event.actor.avatar_url),
            SizedBox(width: duSetWidth(12),),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(event.actor.name,
                    style: TextStyle(
                        color: HexColor('#6B9BF2'),
                        fontSize: duSetFontSize(AppConfig.EVENT_NAME_SIZE),
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Text(RelativeDateFormat.format(event.createdAt),
                    style: TextStyle(
                        color: AppTheme.descText,
                        fontSize: duSetFontSize(AppConfig.EVENT_TIME_SIZE),
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Container(
                    width: double.infinity,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          style: TextStyle(
                            fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE),
                            color: AppTheme.darkText,
                          ),
                          children: <InlineSpan>[
                            TextSpan(text: '关注了仓库'),
                            TextSpan(text: ' ' + event.repo.humanName + ' ', style: TextStyle(
                                color: HexColor('#6B9BF2'),
                                fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                            )),
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else if(event.type == EventType.FORK_EVENT) {
      return Container(
        margin: EdgeInsets.only(bottom: duSetHeight(10)),
        padding: EdgeInsets.all(duSetFontSize(12)),
        width: double.infinity,
        decoration: BoxDecoration(
            color: HexColor('#FAFDFC'),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.16),
                  blurRadius: 15.0, //阴影模糊程度
                  spreadRadius: 0.5 //阴影扩散程度
              ),
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _AvatarWidget(url: event.actor.avatar_url),
            SizedBox(width: duSetWidth(12),),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(event.actor.name,
                    style: TextStyle(
                        color: HexColor('#6B9BF2'),
                        fontSize: duSetFontSize(AppConfig.EVENT_NAME_SIZE),
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Text(RelativeDateFormat.format(event.createdAt),
                    style: TextStyle(
                        color: AppTheme.descText,
                        fontSize: duSetFontSize(AppConfig.EVENT_TIME_SIZE),
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Container(
                    width: double.infinity,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          style: TextStyle(
                            fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE),
                            color: AppTheme.darkText,
                          ),
                          children: <InlineSpan>[
                            TextSpan(text: 'Fork了仓库'),
                            TextSpan(text: ' ' + event.repo.humanName + ' ', style: TextStyle(
                                color: HexColor('#6B9BF2'),
                                fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                            )),
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else if(event.type == EventType.ISSUE_EVENT) {
      return Container(
        margin: EdgeInsets.only(bottom: duSetHeight(10)),
        padding: EdgeInsets.all(duSetFontSize(12)),
        width: double.infinity,
        decoration: BoxDecoration(
            color: HexColor('#FAFDFC'),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.16),
                  blurRadius: 15.0, //阴影模糊程度
                  spreadRadius: 0.5 //阴影扩散程度
              ),
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _AvatarWidget(url: event.actor.avatar_url),
            SizedBox(width: duSetWidth(12),),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(event.actor.name,
                    style: TextStyle(
                        color: HexColor('#6B9BF2'),
                        fontSize: duSetFontSize(AppConfig.EVENT_NAME_SIZE),
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Text(RelativeDateFormat.format(event.createdAt),
                    style: TextStyle(
                        color: AppTheme.descText,
                        fontSize: duSetFontSize(AppConfig.EVENT_TIME_SIZE),
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Container(
                    width: double.infinity,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          style: TextStyle(
                            fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE),
                            color: AppTheme.darkText,
                          ),
                          children: <InlineSpan>[
                            TextSpan(text: '对'),
                            TextSpan(text: ' ' + event.repo.humanName + ' ', style: TextStyle(
                                color: HexColor('#6B9BF2'),
                                fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                            )),
                            TextSpan(text: '仓库创建了新的Issue:'),
                            TextSpan(text: ' #' + event.payload.number + ' ', style: TextStyle(
                                color: HexColor('#6B9BF2'),
                                fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                            )),
                            TextSpan(text: ' ' + event.payload.title + ' ', style: TextStyle(
                                color: AppTheme.dark_grey,
                                fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                            )),
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }else if(event.type == EventType.ISSUE_COMMENT_EVENT){
      return Container(
        margin: EdgeInsets.only(bottom: duSetHeight(10)),
        padding: EdgeInsets.all(duSetFontSize(12)),
        width: double.infinity,
        decoration: BoxDecoration(
            color: HexColor('#FAFDFC'),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.16),
                  blurRadius: 15.0, //阴影模糊程度
                  spreadRadius: 0.5 //阴影扩散程度
              ),
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _AvatarWidget(url: event.actor.avatar_url),
            SizedBox(width: duSetWidth(12),),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(event.actor.name,
                    style: TextStyle(
                        color: HexColor('#6B9BF2'),
                        fontSize: duSetFontSize(AppConfig.EVENT_NAME_SIZE),
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Text(RelativeDateFormat.format(event.createdAt),
                    style: TextStyle(
                        color: AppTheme.descText,
                        fontSize: duSetFontSize(AppConfig.EVENT_TIME_SIZE),
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Container(
                    width: double.infinity,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          style: TextStyle(
                            fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE),
                            color: AppTheme.darkText,
                          ),
                          children: <InlineSpan>[
                            TextSpan(text: '评论了'),
                            TextSpan(text: ' ' + event.repo.humanName + ' ', style: TextStyle(
                                color: HexColor('#6B9BF2'),
                                fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                            )),
                            TextSpan(text: '的 Issue'),
                            TextSpan(text: ' #' + event.payload.issue.number + ' ' + event.payload.issue.title + '：', style: TextStyle(
                                color: HexColor('#6B9BF2'),
                                fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                            )),
                            TextSpan(text: ' ' + event.payload.comment.body + ' ', style: TextStyle(
                                color: AppTheme.dark_grey,
                                fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                            )),
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }else if(event.type == EventType.PULL_REQUEST_EVENT){
      return Container(
        margin: EdgeInsets.only(bottom: duSetHeight(10)),
        padding: EdgeInsets.all(duSetFontSize(12)),
        width: double.infinity,
        decoration: BoxDecoration(
            color: HexColor('#FAFDFC'),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.16),
                  blurRadius: 15.0, //阴影模糊程度
                  spreadRadius: 0.5 //阴影扩散程度
              ),
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _AvatarWidget(url: event.actor.avatar_url),
            SizedBox(width: duSetWidth(12),),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(event.actor.name,
                    style: TextStyle(
                        color: HexColor('#6B9BF2'),
                        fontSize: duSetFontSize(AppConfig.EVENT_NAME_SIZE),
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Text(RelativeDateFormat.format(event.createdAt),
                    style: TextStyle(
                        color: AppTheme.descText,
                        fontSize: duSetFontSize(AppConfig.EVENT_TIME_SIZE),
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Container(
                    width: double.infinity,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          style: TextStyle(
                            fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE),
                            color: AppTheme.darkText,
                          ),
                          children: <InlineSpan>[
                            TextSpan(text: '对仓库'),
                            TextSpan(text: ' ' + event.repo.humanName + ' ', style: TextStyle(
                                color: HexColor('#6B9BF2'),
                                fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                            )),
                            TextSpan(text: '进行了 PullRequest 操作'),
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }else if(event.type == EventType.PULL_REQUEST_REVIEW_COMMENT_EVENT){
      return Container(
        margin: EdgeInsets.only(bottom: duSetHeight(10)),
        padding: EdgeInsets.all(duSetFontSize(12)),
        width: double.infinity,
        decoration: BoxDecoration(
            color: HexColor('#FAFDFC'),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.16),
                  blurRadius: 15.0, //阴影模糊程度
                  spreadRadius: 0.5 //阴影扩散程度
              ),
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _AvatarWidget(url: event.actor.avatar_url),
            SizedBox(width: duSetWidth(12),),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(event.actor.name,
                    style: TextStyle(
                        color: HexColor('#6B9BF2'),
                        fontSize: duSetFontSize(AppConfig.EVENT_NAME_SIZE),
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Text(RelativeDateFormat.format(event.createdAt),
                    style: TextStyle(
                        color: AppTheme.descText,
                        fontSize: duSetFontSize(AppConfig.EVENT_TIME_SIZE),
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Container(
                    width: double.infinity,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          style: TextStyle(
                            fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE),
                            color: AppTheme.darkText,
                          ),
                          children: <InlineSpan>[
                            TextSpan(text: event.payload.action + ' a pullRequest comment in'),
                            TextSpan(text: ' ' + event.repo.humanName + ' ', style: TextStyle(
                                color: HexColor('#6B9BF2'),
                                fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                            )),
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }else if(event.type == EventType.COMMIT_COMMENT_EVENT){
      return Container(
        margin: EdgeInsets.only(bottom: duSetHeight(10)),
        padding: EdgeInsets.all(duSetFontSize(12)),
        width: double.infinity,
        decoration: BoxDecoration(
            color: HexColor('#FAFDFC'),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.16),
                  blurRadius: 15.0, //阴影模糊程度
                  spreadRadius: 0.5 //阴影扩散程度
              ),
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _AvatarWidget(url: event.actor.avatar_url),
            SizedBox(width: duSetWidth(12),),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(event.actor.name,
                    style: TextStyle(
                        color: HexColor('#6B9BF2'),
                        fontSize: duSetFontSize(AppConfig.EVENT_NAME_SIZE),
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Text(RelativeDateFormat.format(event.createdAt),
                    style: TextStyle(
                        color: AppTheme.descText,
                        fontSize: duSetFontSize(AppConfig.EVENT_TIME_SIZE),
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Container(
                    width: double.infinity,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                          style: TextStyle(
                            fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE),
                            color: AppTheme.darkText,
                          ),
                          children: <InlineSpan>[
                            TextSpan(text: 'creates a commit comment in '),
                            TextSpan(text: ' ' + event.repo.humanName + ' ', style: TextStyle(
                                color: HexColor('#6B9BF2'),
                                fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                            )),
                          ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }else if(event.type == EventType.MEMBER_EVENT){
      return Container(
        margin: EdgeInsets.only(bottom: duSetHeight(10)),
        padding: EdgeInsets.all(duSetFontSize(12)),
        width: double.infinity,
        decoration: BoxDecoration(
            color: HexColor('#FAFDFC'),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.16),
                  blurRadius: 15.0, //阴影模糊程度
                  spreadRadius: 0.5 //阴影扩散程度
              ),
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _AvatarWidget(url: event.actor.avatar_url),
            SizedBox(width: duSetWidth(12),),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(event.actor.name,
                    style: TextStyle(
                        color: HexColor('#6B9BF2'),
                        fontSize: duSetFontSize(AppConfig.EVENT_NAME_SIZE),
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Text(RelativeDateFormat.format(event.createdAt),
                    style: TextStyle(
                        color: AppTheme.descText,
                        fontSize: duSetFontSize(AppConfig.EVENT_TIME_SIZE),
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Container(
                    width: double.infinity,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(style: TextStyle(
                        fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE),
                        color: AppTheme.darkText,
                      ), children: <InlineSpan>[
                        TextSpan(text: '对仓库'),
                        TextSpan(text: ' ' + event.repo.humanName + ' ', style: TextStyle(
                            color: HexColor('#6B9BF2'),
                            fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                        )),
                        TextSpan(text: '添加了新成员'),
                      ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }else if(event.type == EventType.STAR_EVENT){
      return Container(
        margin: EdgeInsets.only(bottom: duSetHeight(10)),
        padding: EdgeInsets.all(duSetFontSize(12)),
        width: double.infinity,
        decoration: BoxDecoration(
            color: HexColor('#FAFDFC'),
            borderRadius: BorderRadius.all(Radius.circular(16)),
            //border: Border.all(width: 1, color: Colors.grey.withOpacity(.4)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.16),
                  blurRadius: 15.0, //阴影模糊程度
                  spreadRadius: 0.5 //阴影扩散程度
              ),
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _AvatarWidget(url: event.actor.avatar_url),
            SizedBox(width: duSetWidth(12),),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(event.actor.name,
                    style: TextStyle(
                        color: HexColor('#6B9BF2'),
                        fontSize: duSetFontSize(AppConfig.EVENT_NAME_SIZE),
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Text(RelativeDateFormat.format(event.createdAt),
                    style: TextStyle(
                        color: AppTheme.descText,
                        fontSize: duSetFontSize(AppConfig.EVENT_TIME_SIZE),
                        fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: duSetHeight(6)),
                  Container(
                    width: double.infinity,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(style: TextStyle(
                        fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE),
                        color: AppTheme.darkText,
                      ), children: <InlineSpan>[
                        TextSpan(text: '收藏了'),
                        TextSpan(text: ' ' + event.repo.humanName + ' ', style: TextStyle(
                            color: HexColor('#6B9BF2'),
                            fontSize: duSetFontSize(AppConfig.EVENT_CONTENT_SIZE)
                        )),
                        TextSpan(text: '这个仓库'),
                      ]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }else {
      return SizedBox();
    }
  }

  Widget _AvatarWidget ({String url}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(.2),
          borderRadius: BorderRadius.all(Radius.circular(14.0))
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14.0),
        child: Image.network(url,
          width: duSetWidth(56),
          height: duSetHeight(52),
        ),
      ),
    );
  }
}