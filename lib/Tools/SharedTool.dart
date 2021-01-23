// 分享工具类

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:zhishu_card/Home/Models/HomeModel.dart';
import 'package:zhishu_card/Tools/SqliteTool.dart';
import '../Home/Models/HomeModel.dart';

class SharedTool {
  static var shared = SharedTool();

  // 全部任务
  void sharedAllTask() async {}

  // 今天任务读取
  Future<String> sharedReadCurrentTask() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    return shared.getString("currentTask");
  }

  // 今天任务写入
  void sharedCurrentTask(List<HomeModel> dataList) async {
    List<Map> list = [];
    for (var model in dataList) {
      Map c = model.toJson();
      list.add(c);
    }
    list.forEach((element) {});
    final currentTaskString = JSONTool.toJSONString(list);
    SharedPreferences shared = await SharedPreferences.getInstance();
    final String str = shared.getString("currentTask");
    if (str == currentTaskString) {
      return;
    } else {
      shared.setString("currentTask", currentTaskString);
    }
  }

  // 今天时间
  void sharedCurrentTime() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    DateTime time = DateTime.now();
    final nowDay = DateFormat("yyyy-MM-dd").format(time);
    final String saveDay = shared.getString("currentTime");
    // todo
    if (nowDay != saveDay) {
      print("时间和上次保存不同 $nowDay");
      shared.setString("currentTime", nowDay);
      // 数据库保存信息
      sharedReadCurrentTask().then((value) {
        print("上次任务-----$value");
        SqliteTool.insertFromYesterday(value);
      });
    } else {
      print("时间和上次保存相同 $nowDay");
    }
  }
}

// JSON工具类
class JSONTool {
  // 转json字符串
  static String toJSONString<T>(T object) {
    return jsonEncode(object);
  }

  // json转class(list map)
  static dynamic toClass(String string) {
    return jsonDecode(string);
  }
}
