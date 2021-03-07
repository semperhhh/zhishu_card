import 'package:zhishu_card/Tools/UserPrefereTool.dart';

import 'ColorUtil.dart';
import 'MainTool.dart';
import 'package:flutter/material.dart';

// 全局主题
class ThemeModel extends ChangeNotifier {
  // 主题
  ThemeMode themeMode = UserPrefereTool.currentThemeMode();

  set theme(ThemeMode mode) {
    if (mode != themeMode) {
      themeMode = mode;
      UserPrefereTool.changeThemeMode(mode.index);
      notifyListeners();
      print("主题发生改变-$mode");
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static ThemeData getTheme({bool isDarkMode = false}) {
    return ThemeData(
      platform: TargetPlatform.iOS,
      primaryColor: ColorUtil.main_app,
      primaryIconTheme: IconThemeData(
          color:
              isDarkMode ? ColorUtil.main_light_app : ColorUtil.main_dark_app),
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        color: isDarkMode ? ColorUtil.main_dark1_app : ColorUtil.main_app,
        shadowColor: isDarkMode ? ColorUtil.main_dark1_app : Colors.white,
      ),
      fontFamily: fontPingFange,
      splashColor: Colors.transparent, // 水波纹
      highlightColor: Colors.transparent,
      backgroundColor: isDarkMode ? ColorUtil.main_dark_app : ColorUtil.grey,
      textTheme: TextTheme(
        bodyText2: TextStyle(
            color: isDarkMode
                ? ColorUtil.main_light_app
                : ColorUtil.main_dark_app),
      ),
    );
  }
}
