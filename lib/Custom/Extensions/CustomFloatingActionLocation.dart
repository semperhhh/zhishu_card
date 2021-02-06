import 'package:flutter/material.dart';

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {

  // tabbar中间按钮
  static CustomFloatingActionButtonLocation tabbarCenter =
      _tabbarCenterLocation();

  static CustomFloatingActionButtonLocation _tabbarCenterLocation() {
    return CustomFloatingActionButtonLocation(
        FloatingActionButtonLocation.miniCenterDocked, 0, 20);
  }

  FloatingActionButtonLocation location;
  double offsetX;
  double offsetY;
  CustomFloatingActionButtonLocation(this.location, this.offsetX, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(offset.dx + offsetX, offset.dy + offsetY);
  }
}
