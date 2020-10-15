import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

/// 矩形高斯模糊效果
class BlurRectWidget extends StatefulWidget {
  final Widget child;

  /// 模糊值
  final double sigmaX;
  final double sigmaY;

  /// 透明度
  final double opacity;

  /// 外边距
  final EdgeInsetsGeometry blurMargin;

  /// 圆角
  final BorderRadius borderRadius;

  const BlurRectWidget({
    Key key,
    this.child,
    this.sigmaX,
    this.sigmaY,
    this.opacity,
    this.blurMargin,
    this.borderRadius,
  }) : super(key: key);

  @override
  _BlurRectWidgetState createState() => _BlurRectWidgetState();
}

class _BlurRectWidgetState extends State<BlurRectWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.blurMargin != null
          ? widget.blurMargin
          : EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
      child: ClipRRect(
        borderRadius: widget.borderRadius == null ? BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)) : widget.borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: this.widget.sigmaX != null ? this.widget.sigmaX : 10,
            sigmaY: this.widget.sigmaY != null ? this.widget.sigmaY : 10,
          ),
          child: Container(
            color: Colors.white10,
            child: this.widget.opacity != null
                ? Opacity(
              opacity: widget.opacity,
              child: this.widget.child,
            )
                : this.widget.child,
          ),
        ),
      ),
    );
  }
}