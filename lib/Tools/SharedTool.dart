// 分享工具类

import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class SharedTool {
  static var shared = SharedTool();

  // 全部任务
  void sharedAllTask() async {}

  // 今天任务
  void sharedCurrentTask() async {}

  // 今天时间
  void sharedCurrentTime() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    DateTime time = DateTime.now();
    final nowDay = DateFormat("yyyy-MM-dd").format(time);
    final String saveDay = shared.getString("currentTime");
    if (nowDay != saveDay) {
      print("时间和上次保存不同 $nowDay");
      shared.setString("currentTime", nowDay);
      // 数据库保存信息
    } else {
      print("时间和上次保存相同 $nowDay");
    }
  }
}
