
import 'package:fitee/config/config.dart';
import 'package:fitee/model/release/release.dart';
import 'package:fitee/model/release/release_provider.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/relative_date_format.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/store.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/avatar/avatar.dart';
import 'package:fitee/widgets/foot/no_more_footer.dart';
import 'package:fitee/widgets/loading/FiteeLoading.dart';
import 'package:fitee/widgets/markdown/markdown.dart';
import 'package:fitee/widgets/state/state_page.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ReleasePage extends StatefulWidget {

  final String fullName;

  ReleasePage({Key key, this.fullName}): super(key: key);


  _ReleasePageState createState() => _ReleasePageState();
}

class _ReleasePageState extends State<ReleasePage> {

  int page = 1;
  ReleaseProvider _releaseProvider;

  @override
  void initState() {
    super.initState();
    this.initData();
  }

  initData() async {
    _releaseProvider = Store.value<ReleaseProvider>(NavUtil.ctx);
    await Store.value<ReleaseProvider>(NavUtil.ctx).onClear();
    await Store.value<ReleaseProvider>(NavUtil.ctx).setFullName(fullName: widget.fullName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.white,
      child: SafeArea(
        child: Scaffold(
          body: Store.connect<ReleaseProvider>(builder: (context, state, child){
            return state.loading ? FiteeLoading() : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AppBarWidget(
                  title: 'Releases',
                  back: true,
                ),
                Expanded(
                  child: Container(
                    color: HexColor('#FAFDFC'),
                    child: EasyRefresh.custom(
                        emptyWidget: state.status == AppConfig.NORMAL_STATE ? null : StatePage(state: state.status),
                        header: TaurusHeader(
                            backgroundColor: AppTheme.dismissibleBackground,
                            completeDuration: Duration(milliseconds: 1200)
                        ),
                        footer: state.status != AppConfig.NO_MORE_STATE ? BallPulseFooter(
                          color: AppTheme.darkText,
                        ) : NoMoreFooter(
                            title: '—— 没有更多了 ——'
                        ),
                        onRefresh: () async {
                          setState(() {
                            page = 1;
                          });
                          _releaseProvider.setPage(page: page);
                        },
                        onLoad: () async {
                          setState(() {
                            page++;
                          });
                          _releaseProvider.setPage(page: page);
                        },
                        slivers: <Widget>[
                          AnimationLimiter(
                            child: SliverList(delegate: SliverChildBuilderDelegate((context, index) {
                              Release release = state.result[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: duSetHeight(index == 0 ? 12: 0),
                                ),
                                child: AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 475),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: duSetHeight(10)),
                                          padding: EdgeInsets.symmetric(horizontal: duSetWidth(16), vertical: duSetHeight(6)),
                                          width: double.infinity,
                                          color: HexColor('#FAFDFC'),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Image.asset("assets/icon/tags.png", width: duSetWidth(16), height: duSetHeight(16), color: HexColor('#0079FA'),),
                                                      SizedBox(width: duSetWidth(6),),
                                                      Text(release.tagName,
                                                        style: TextStyle(
                                                          fontSize: duSetFontSize(18),
                                                          color: AppTheme.darkText,
                                                          fontWeight: FontWeight.w500
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: duSetHeight(6)),
                                                  Container(
                                                    width: duSetWidth(108),
                                                    child: Text(RelativeDateFormat.format(release.createdAt),
                                                      style: TextStyle(
                                                          color: AppTheme.descText,
                                                          fontSize: duSetHeight(12)
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: duSetHeight(16)),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(width: 1, color: AppTheme.descText),
                                                          borderRadius: BorderRadius.all(Radius.circular(24))
                                                        ),
                                                        child: Avatar(
                                                          url: release.author.avatar_url,
                                                          name: release.author.login,
                                                          width: duSetWidth(24),
                                                          height: duSetHeight(20),
                                                        ),
                                                      ),
                                                      SizedBox(width: duSetWidth(6),),
                                                      Text(release.author.name,
                                                        style: TextStyle(
                                                          fontSize: duSetFontSize(16),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: duSetWidth(4),),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(left: duSetWidth(10)),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      left: BorderSide(
                                                        color: HexColor('#1A94FA'),
                                                        width: 2
                                                      )
                                                    )
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      RichText(
                                                        textAlign: TextAlign.start,
                                                        text: TextSpan(
                                                            style: TextStyle(
                                                              fontSize: duSetFontSize(18),
                                                              color: AppTheme.darkText,
                                                              fontWeight: FontWeight.w500
                                                            ),
                                                            children: <InlineSpan>[
                                                              TextSpan(text: release.name),
                                                            ]
                                                        ),
                                                      ),
                                                      Container(
                                                        child: FiteeMarkdown(data: release.body),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                ),
                              );
                            },
                                childCount: state.result.length
                            ),
                            ),
                          )
                        ]
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }

}