import 'package:flutter/material.dart';
import 'ColorUtil.dart';
import 'MainTool.dart';

class ThemeTool {
  static bool isDark(BuildContext context) {
    final ThemeData themedata = Theme.of(context);
    return themedata.brightness == Brightness.dark;
  }

  static ThemeData getTheme(bool isDark) {
    return ThemeData(
      platform: TargetPlatform.iOS,
      primaryColor: ColorUtil.main_app,
      brightness: isDark ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
          color: isDark ? ColorUtil.main_dark_app : ColorUtil.main_app,
          shadowColor: Colors.white),
      fontFamily: fontPingFange,
      splashColor: Colors.transparent, // 水波纹
      highlightColor: Colors.transparent,
      textTheme: TextTheme(
        bodyText2: TextStyle(
            color: isDark ? ColorUtil.main_light_app : ColorUtil.main_dark_app),
      ),
    );
  }
}
