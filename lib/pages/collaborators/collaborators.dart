
import 'package:fitee/components/user/UserItem.dart';
import 'package:fitee/model/user/user.dart';
import 'package:fitee/model/user/user_provider.dart';
import 'package:fitee/theme/app_theme.dart';
import 'package:fitee/utils/nav_util.dart';
import 'package:fitee/utils/screen.dart';
import 'package:fitee/utils/store.dart';
import 'package:fitee/widgets/loading/FiteeLoading.dart';
import 'package:fitee/widgets/top/app_bar_widget.dart';
import 'package:flutter/material.dart';

class Collaborators extends StatefulWidget {

  String fullName;

  Collaborators({Key key, this.fullName}): super(key: key);

  _CollaboratorsState createState() => _CollaboratorsState();
}

class _CollaboratorsState extends State<Collaborators> {

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    await Store.value<UserProvider>(NavUtil.ctx).setClear();
    await Store.value<UserProvider>(NavUtil.ctx).fetchCollaborators(fullName: widget.fullName);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: AppTheme.white,
      child: Scaffold(
        body: Store.connect<UserProvider>(builder: (context, state, child){
          return  state.loading ? FiteeLoading() : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AppBarWidget(
                title: '项目成员',
                back: true,
              ),
              Expanded(
                child: Container(
                  color: AppTheme.mainBackground,
                  child: MediaQuery.removePadding(context: context,
                    removeTop: true,
                    removeBottom: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: duSetWidth(12), horizontal: duSetHeight(12)),
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              User user = state.collaborators[index];
                              return UserItem(user: user);
                            },
                            itemCount: state.collaborators.length,
                          ),
                        )
                      ],
                    )
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom,)
            ]
          );
        }),
      ),
    );
  }

}