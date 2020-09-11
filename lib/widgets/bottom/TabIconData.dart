import 'package:flutter/animation.dart';

class TabIconData {

  String imagePath;
  String selectImagePath;
  bool isSelected;
  int index;

  AnimationController animationController;

  TabIconData({
    this.imagePath = '',
    this.selectImagePath = '',
    this.isSelected = false,
    this.index = 0,
    this.animationController});

  static List<TabIconData> list = <TabIconData>[
    TabIconData(
      imagePath: 'assets/bottom/home_unselect.png',
      selectImagePath: 'assets/bottom/home_selected.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/bottom/discovery_unselect.png',
      selectImagePath: 'assets/bottom/discovery_selected.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/bottom/notice_unselect.png',
      selectImagePath: 'assets/bottom/notice_selected.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/bottom/minie_unselect.png',
      selectImagePath: 'assets/bottom/mine_selected.png',
      index: 3,
      isSelected: false,
      animationController: null,
    )
  ];
}