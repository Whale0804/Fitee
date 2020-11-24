import 'package:fitee/model/user/user.dart';
import 'package:fitee/model/user/user_provider.dart';
import 'package:fitee/plugin/blur_rect.dart';
import 'package:fitee/plugin/toast.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/relative_date_format.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/store.dart';
import 'package:fitee/utils/utils.dart';
import 'package:fitee/widgets/avatar/avatar.dart';
import 'package:flutter/material.dart';

class UserItem extends StatefulWidget {

  final User user;

  UserItem({Key key,@required this.user}):super(key: key);

  _UserItemState createState() => _UserItemState();
}

class _UserItemState extends State<UserItem> with TickerProviderStateMixin {

  double height = 0;
  bool isFollow = false;
  UserProvider _userProvider;
  @override
  void initState() {
    super.initState();
    _userProvider = Store.value<UserProvider>(NavUtil.ctx);
    _initData();
  }

  _initData() async {
    isFollow = await _userProvider.fetchCheckFollow(username: widget.user.login);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: duSetHeight(10)),
          padding: EdgeInsets.symmetric(vertical: duSetHeight(8),horizontal: duSetWidth(24)),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.white,
                ),
                child: Avatar(
                  url: widget.user.avatar_url,
                  name: widget.user.login,
                  width: duSetWidth(70),
                  height: duSetHeight(70),
                ),
              ),
              SizedBox(width: duSetWidth(20)),
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.user.name,
                    style: TextStyle(
                        color: AppTheme.darkText,
                        fontSize: duSetHeight(18),
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: duSetHeight(4)),
                  Text('@' + widget.user.login,
                    style: TextStyle(
                        color: HexColor('#6FA0FB'),
                        fontSize: duSetHeight(16)
                    ),
                  ),
                  SizedBox(height: duSetHeight(4)),
                  widget.user.created_at != null ? Text(RelativeDateFormat.format(widget.user.created_at),
                    style: TextStyle(
                        color: AppTheme.descText,
                        fontSize: duSetHeight(14)
                    ),
                  ): SizedBox(),
                ],
              )),
              Container(
                child: Center(
                  child: GestureDetector(
                    child: Icon(Icons.more_vert,
                      color: AppTheme.nearlyBlack,
                      size: duSetFontSize(28),
                    ),
                    onTap: () {
                      setState(() {
                        height = context.size.height - 12;
                      });
                      _userProvider.fetchCheckFollow(username: widget.user.login);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        BlurRectWidget(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              width: double.infinity,
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(vertical: duSetHeight(8),horizontal: duSetWidth(24)),
              height: height,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: duSetHeight(50),
                      width: duSetWidth(56),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.9),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Center(
                        child: Store.connect<UserProvider>(builder: (context, state,child) {
                          return GestureDetector(
                            child: Icon(isFollow ? Icons.star : Icons.star_border_outlined,
                              color: AppTheme.nearlyBlack,
                              size: duSetFontSize(28),
                            ),
                            onTap: () async {
                              bool temp;
                              if(isFollow) { // 取消关注
                                temp = await state.fetchUnFollow(username: widget.user.login);
                              }else { // 关注
                                temp = await state.fetchFollow(username: widget.user.login);
                              }
                              setState(() {
                                isFollow = temp;
                              });
                            },
                          );
                        }),
                      ),
                    ),
                    Container(
                      height: duSetHeight(50),
                      width: duSetWidth(56),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.9),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: Center(
                        child: GestureDetector(
                          child: Icon(Icons.comment_outlined,
                            color: AppTheme.nearlyBlack,
                            size: duSetFontSize(28),
                          ),
                          onTap: () {
                            Toast.toast(context,
                                msg: '接口不支持啦~'
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              setState(() {
                height = 0;
              });
            },
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          blurMargin: EdgeInsets.only(bottom: 0),
        ),
      ],
    );
  }

}