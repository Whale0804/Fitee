
import 'package:fitee/config/config.dart';
import 'package:fitee/model/letter/letter.dart';
import 'package:fitee/model/letter/letter_provider.dart';
import 'package:fitee/model/notify/notify.dart';
import 'package:fitee/model/notify/notify_provider.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/relative_date_format.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/store.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/avatar/avatar.dart';
import 'package:fitee/widgets/loading/FiteeLoading.dart';
import 'package:fitee/widgets/state/state_page.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class NoticePage extends StatefulWidget{

  @override
  _NoticePageState createState()=> _NoticePageState();
}

class _NoticePageState extends State<NoticePage> with TickerProviderStateMixin{
  LetterProvider _letterProvider;
  NotifyProvider _notifyProvider;
  TabController _controller;

  AnimationController _animationController;
  Animation<Color> _animation;

  int tabIndex = 0;
  int page = 1;

  @override
  void initState() {
    super.initState();
    _letterProvider = Store.value<LetterProvider>(NavUtil.ctx);
    _notifyProvider = Store.value<NotifyProvider>(NavUtil.ctx);
    _controller = TabController(
      length: 3,
      vsync: ScrollableState(),
    );
    _controller.addListener(() {
      setState(() {
        tabIndex = _controller.index;
        page = 1;
        _initData();
      });
    });

    _animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    _animation = Tween<Color>(begin: AppTheme.dismissibleBackground.withOpacity(.3), end: AppTheme.dismissibleBackground)
        .animate(_animationController);

    _initData();
  }

  _initData() async {
    if(tabIndex == 0) {
      _letterProvider.fetchLetter();
    }else if(tabIndex == 1){
      _notifyProvider.fetchAllNotify();
    }else if(tabIndex == 2){
      _notifyProvider.fetchMyNotify();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
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
                title: 'Notice'
            ),
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: TabBar(
                        controller: _controller,
                        labelColor: AppTheme.darkText,
                        unselectedLabelColor: AppTheme.descText,
                        indicatorColor: Colors.transparent,
                        labelStyle: TextStyle(fontWeight: FontWeight.w500),
                        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: <Widget>[
                          _tabItem(
                            image: Image.asset('assets/icon/letter.png', width: duSetWidth(21), height: duSetHeight(21),
                              color: tabIndex == 0 ? HexColor('#171717') : AppTheme.descText,
                            ),
                            text: '私信',
                          ),
                          _tabItem(
                              image: Image.asset('assets/icon/message.png', width: duSetWidth(21), height: duSetHeight(21),
                                color: tabIndex == 1 ? HexColor('#171717') : AppTheme.descText,
                              ),
                              text: '通知',
                          ),
                          _tabItem(
                              image: Image.asset('assets/icon/at.png', width: duSetWidth(20), height: duSetHeight(20),
                                color: tabIndex == 2 ? HexColor('#171717') : AppTheme.descText,
                              ),
                              text: '我',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _controller,
                        children: <Widget>[
                          _letterList(context),
                          _notifyList(context),
                          _notifyMyList(context),
                        ],
                      ),
                    )
                  ],
                )
            ),
          ]
      ),
    );
  }

  Widget _letterList(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: duSetHeight(6)),
        Expanded(
          child: Store.connect<LetterProvider>(
            builder: (context, state, child) {
              return state.loading ?
              FiteeLoading() :
              EasyRefresh.custom(
                emptyWidget: state.status == AppConfig.NORMAL_STATE ? null : StatePage(state: state.status),
                header: TaurusHeader(
                    backgroundColor: AppTheme.dismissibleBackground,
                    completeDuration: Duration(milliseconds: 1200)
                ),
                footer: MaterialFooter(
                    valueColor: _animation,
                ),
                onRefresh: () async{
                  setState(() {
                    page = 1;
                  });
                  _letterProvider.setPage(page: page);
                },
                onLoad: () async {
                  setState(() {
                    page++;
                  });
                  _letterProvider.setPage(page: page);
                },
                slivers: <Widget>[
                  AnimationLimiter(
                    child: SliverList(delegate: SliverChildBuilderDelegate((context, index) {
                      Letter letter = state.result[index];
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
                              child: _letterItem(letter: letter),
                            ),
                          ),
                        ),
                      );
                    },
                        childCount: state.result.length
                    )
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((content, index) {
                      return Container(
                        height: duSetHeight(35),
                        color: Colors.transparent,
                      );
                    }, childCount: 1),
                  ),
                ],
              );
            }
          ),
        )
      ],
    );
  }

  Widget _notifyList(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: duSetHeight(6)),
        Expanded(
          child: Store.connect<NotifyProvider>(
              builder: (context, state, child) {
                return state.allLoading ?
                FiteeLoading() :
                EasyRefresh.custom(
                  emptyWidget: state.allStatus == AppConfig.NORMAL_STATE ? null : StatePage(state: state.allStatus),
                  header: TaurusHeader(
                      backgroundColor: AppTheme.dismissibleBackground,
                      completeDuration: Duration(milliseconds: 1200)
                  ),
                  footer: MaterialFooter(
                    valueColor: _animation,
                  ),
                  onRefresh: () async{
                    setState(() {
                      page = 1;
                    });
                    _notifyProvider.setAllPage(page: page);
                  },
                  onLoad: () async {
                    setState(() {
                      page++;
                    });
                    _notifyProvider.setAllPage(page: page);
                  },
                  slivers: <Widget>[
                    AnimationLimiter(
                      child: SliverList(delegate: SliverChildBuilderDelegate((context, index) {
                        Notify notify = state.allResult[index];
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
                                child: _notifyItem(notify: notify),
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
                          height: duSetHeight(35),
                          color: Colors.transparent,
                        );
                      }, childCount: 1),
                    ),
                  ],
                );
              }
          ),
        )
      ],
    );
  }

  Widget _notifyMyList(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: duSetHeight(6)),
        Expanded(
          child: Store.connect<NotifyProvider>(
              builder: (context, state, child) {
                return state.myLoading ?
                FiteeLoading() :
                EasyRefresh.custom(
                  emptyWidget: state.myStatus == AppConfig.NORMAL_STATE ? null : StatePage(state: state.myStatus),
                  header: TaurusHeader(
                      backgroundColor: AppTheme.dismissibleBackground,
                      completeDuration: Duration(milliseconds: 1200)
                  ),
                  footer: MaterialFooter(
                    valueColor: _animation,
                  ),
                  onRefresh: () async{
                    setState(() {
                      page = 1;
                    });
                    _notifyProvider.setMyPage(page: page);
                  },
                  onLoad: () async {
                    setState(() {
                      page++;
                    });
                    _notifyProvider.setMyPage(page: page);
                  },
                  slivers: <Widget>[
                    AnimationLimiter(
                      child: SliverList(delegate: SliverChildBuilderDelegate((context, index) {
                        Notify notify = state.myResult[index];
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
                                child: _notifyItem(notify: notify),
                              ),
                            ),
                          ),
                        );
                      },
                          childCount: state.myResult.length
                      )
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((content, index) {
                        return Container(
                          height: duSetHeight(35),
                          color: Colors.transparent,
                        );
                      }, childCount: 1),
                    ),
                  ],
                );
              }
          ),
        )
      ],
    );
  }

  Widget _letterItem({@required Letter letter}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: duSetHeight(10)),
      padding: EdgeInsets.all(duSetFontSize(12)),
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
          Avatar(url: letter.sender.avatar_url, name: letter.sender.login),
          SizedBox(width: duSetWidth(12),),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(letter.sender.name,
                  style: TextStyle(
                      color: HexColor('#6B9BF2'),
                      fontSize: duSetFontSize(AppConfig.EVENT_NAME_SIZE),
                      fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: duSetHeight(6)),
                Text(RelativeDateFormat.format(letter.updatedAt),
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
                          TextSpan(text: letter.content)
                        ]),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _notifyItem({@required Notify notify}) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: duSetHeight(10)),
      padding: EdgeInsets.all(duSetFontSize(12)),
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
          Avatar(url: notify.actor.avatar_url, name: notify.actor.login),
          SizedBox(width: duSetWidth(12),),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(notify.actor.name,
                  style: TextStyle(
                      color: HexColor('#6B9BF2'),
                      fontSize: duSetFontSize(AppConfig.EVENT_NAME_SIZE),
                      fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: duSetHeight(6)),
                Text(RelativeDateFormat.format(notify.updatedAt),
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
                          TextSpan(text: notify.content)
                        ]),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget _tabItem({Image image, String text}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //Tab(icon: Icon(Icons.local_florist)),
          image,
          const SizedBox(width: 12,),
          Text(text,
            style: TextStyle(
                fontSize: duSetFontSize(18),
                fontWeight: FontWeight.w400
            ),
          )
        ],
      ),
    );
  }
}