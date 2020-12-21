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
}
