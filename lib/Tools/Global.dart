import 'package:flutter/material.dart';
import 'package:zhishu_card/Tools/FileUtil.dart';
import 'ColorUtil.dart';
import 'MainTool.dart';
import 'UserPrefereTool.dart';
import 'SqliteTool.dart';

class Global {
  static Future init() async {
    await UserPrefereTool.init();
    await SqliteTool.openData();
    await FileUtil.init();
    print("Global load success -----");
  }
}
