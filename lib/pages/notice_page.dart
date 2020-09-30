
import 'package:fitee/model/letter/letter_provider.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/store.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';

class NoticePage extends StatefulWidget{

  @override
  _NoticePageState createState()=> _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  LetterProvider _letterProvider;
  TabController _controller;

  int tabIndex = 0;
  int page = 1;

  @override
  void initState() {
    super.initState();
    _letterProvider = Store.value<LetterProvider>(NavUtil.ctx);
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
    _initData();
  }

  _initData() async {
    if(tabIndex == 0) {
      _letterProvider.fetchLetter();
    }else if(tabIndex == 1){
    }else {
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
                          _TabItem(
                            image: Image.asset('assets/icon/letter.png', width: duSetWidth(21), height: duSetHeight(21),
                              color: tabIndex == 0 ? HexColor('#171717') : AppTheme.descText,
                            ),
                            text: '私信',
                          ),
                          _TabItem(
                              image: Image.asset('assets/icon/message.png', width: duSetWidth(21), height: duSetHeight(21),
                                color: tabIndex == 1 ? HexColor('#171717') : AppTheme.descText,
                              ),
                              text: '通知',
                          ),
                          _TabItem(
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
                          Container(
                            child: Icon(Icons.ac_unit),
                          ),
                          Container(
                            child: Icon(Icons.accessibility),
                          ),
                          Container(
                            child: Icon(Icons.account_balance),
                          ),
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

  Widget _TabItem({Image image, String text}){
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