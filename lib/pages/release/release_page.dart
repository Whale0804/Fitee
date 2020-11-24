
import 'package:fitee/config/config.dart';
import 'package:fitee/model/release/release.dart';
import 'package:fitee/model/release/release_provider.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/store.dart';
import 'package:fitee/widgets/foot/no_more_footer.dart';
import 'package:fitee/widgets/loading/FiteeLoading.dart';
import 'package:fitee/widgets/state/state_page.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
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
                  color: AppTheme.mainBackground,
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
                                  left: duSetWidth(16),
                                  right: duSetWidth(16)
                              ),
                              child: AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 475),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Container(
                                        child: Text(release.name),
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
    );
  }

}