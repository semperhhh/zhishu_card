import 'dart:math';

import 'package:flutter/material.dart';

class ColorUtil {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".

  // 自定义颜色
  static const Color red = Color(0xFFFF4351);
  static const Color orange = Color(0xFFFEAE1B);
  static const Color grey = Color(0xFFEEEEEE);
  static const Color blue = Color(0xFF229ffd);
  static const Color green = Color(0xFFA5DE37);
  static const Color purple = Color(0xFF7B72E9);

  // 主题颜色-绿
  static const Color styleGreen = Color(0xFF21C38F);

  // 颜色生成
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  // 随机颜色
  static Color random() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
        .withOpacity(1.0);
  }

  // 返回一个class, class包含文字颜色, 背景图

}

enum CellColorType { blue, purple, green, orange }

class CellColor {
  final Color bgColor;
  final String imageName;
  final Color timeColor;
  CellColor(this.bgColor, this.imageName, this.timeColor);

  static CellColor random(int time) {
    CellColorType type;
    if (time < 45) {
      type = CellColorType.blue;
    } else if (time < 90) {
      type = CellColorType.green;
    } else if (time < 120) {
      type = CellColorType.purple;
    } else {
      type = CellColorType.orange;
    }
    switch (type) {
      case CellColorType.blue:
        return CellColor(ColorUtil.fromHex("#5B7CFF"), "cell_1",
            ColorUtil.fromHex("#CED7FE"));
      case CellColorType.green:
        return CellColor(ColorUtil.fromHex("#01D5AC"), "cell_2",
            ColorUtil.fromHex("#C9FFF5"));
      case CellColorType.purple:
        return CellColor(ColorUtil.fromHex("#8968FF"), "cell_3",
            ColorUtil.fromHex("#D1C5FF"));
      default:
        return CellColor(ColorUtil.fromHex("#FFB223"), "cell_4",
            ColorUtil.fromHex("#FFF2DB"));
    }
  }
}
