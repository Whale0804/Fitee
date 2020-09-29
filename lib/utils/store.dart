import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'nav_util.dart';

class Store {
  // 无 context 获取值
  static T getValue<T> ({bool listen = false}) {
    return Provider.of(NavKey.navKey.currentContext, listen: listen);
  }



  /*---------------------其它获取 provider 方法--------------------------*/

  //  通过Provider.value<T>(context)获取状态数据
  static T value<T>(BuildContext context, {bool listen = false}) {
    return Provider.of<T>(context, listen: listen);
  }

  //  通过Consumer获取状态数据
  static Consumer connect<T>({Function(BuildContext, T, Widget) builder, Widget child}) {
    return Consumer<T>(builder: builder, child: child);
  }
}