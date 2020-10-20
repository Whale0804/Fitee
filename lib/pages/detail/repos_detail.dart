import 'package:fitee/config/config.dart';
import 'package:fitee/model/repository/repository.dart';
import 'package:fitee/model/repository/repository_provider.dart';
import 'package:fitee/model/user/user_provider.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/store.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/avatar/avatar.dart';
import 'package:fitee/widgets/loading/FiteeLoading.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

// ignore: must_be_immutable
class ReposDetailPage extends StatefulWidget {

  String fullName;
  String humanName;

  ReposDetailPage({Key key, this.fullName, this.humanName}): super(key: key);

  @override
  _ReposDetailState createState()=> _ReposDetailState();
}


class _ReposDetailState extends State<ReposDetailPage> with TickerProviderStateMixin {

  GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    Repository repos = await Store.value<ReposProvider>(NavUtil.ctx).fetchRepos(fullName: widget.fullName);
    await Store.value<UserProvider>(NavUtil.ctx).fetchCheckFollow(username: repos.owner.login);
  }

  @override
  Widget build(BuildContext context) {
    return Store.connect<ReposProvider>(builder:(context, state, child) {
      return state.loading ? FiteeLoading() : Container(
        color: HexColor('#6A60C4'),
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AppBarWidget(
                title: widget.humanName,
                back: true,
                iconColor: Colors.white,
                textColor: Colors.white,
                color: HexColor('#6A60C4'),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: MediaQuery.removeViewPadding(
                    removeTop: true,
                    context: context,
                    child: ListView(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          key: _key,
                          width: double.infinity,
                          padding: EdgeInsets.only(top: duSetHeight(4),bottom: duSetHeight(16), left: duSetWidth(16), right: duSetWidth(16)),
                          decoration: BoxDecoration(
                              color: HexColor('#6A60C4'),
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(45))
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        ClipRRect(
                                            child: Avatar(
                                              url: state.result.owner.avatar_url,
                                              name: state.result.owner.login,
                                              width: duSetWidth(36),
                                              height: duSetHeight(30),
                                              borderRadius: BorderRadius.all(Radius.circular(100)),
                                            ),
                                            borderRadius: BorderRadius.circular(100)
                                        ),
                                        SizedBox(width: 12),
                                        Text(state.result.owner.name,
                                          style: TextStyle(
                                              color: AppTheme.nearlyWhite,
                                              fontSize: duSetFontSize(18.0),
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        Expanded(child: Text('@' + state.result.owner.login,
                                          style: TextStyle(
                                              color: AppTheme.url,
                                              fontSize: duSetFontSize(18.0),
                                              fontWeight: FontWeight.w400
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )) ,
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: duSetWidth(12)),
                                  Container(child: Store.connect<UserProvider>(builder: (context, state, child){
                                    return Image.asset('assets/icon/mutual_following.png', height: duSetHeight(24), width: duSetWidth(24), color: state.isFollow ? Colors.white : AppTheme.nearlyBlack);
                                  }) )
                                ],
                              ),
                              SizedBox(height: duSetHeight(12)),
                              Container(
                                width: double.infinity,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: TextStyle(
                                        fontSize: duSetFontSize(17),
                                        color: AppTheme.nearlyWhite,
                                      ),
                                      children: <InlineSpan>[
                                        TextSpan(text: state.result.description),
                                      ]
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: duSetHeight(14)),
                        Container(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height / 1.9,
                            maxHeight: double.infinity
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(45)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomRight,
                              colors: [
                                HexColor('#D9ECFD'),
                                HexColor('#FFFFFF'),
                                HexColor('#F9F9F9'),
                              ],
                            )
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                height: 1000,
                              ),
                            ],
                          ),
                        )
                     ],
                    ),
                  )
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom)
            ],
          ),
        ),
      );
    });
  }

}