
import 'package:fitee/config/config.dart';
import 'package:flutter/material.dart';

/// 0: 正常， 1: 数据为空， 2: 查询报错
class StatePage extends StatelessWidget {

  String state;

  StatePage({Key key, this.state = '0'}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: state == AppConfig.EMPTY_STATE ? Image.asset('assets/state/empty_list.png') : Image.asset('assets/state/error_list.png'),
      ),
    );
  }

}