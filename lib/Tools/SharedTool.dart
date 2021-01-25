// 分享工具类

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:zhishu_card/Home/Models/HomeModel.dart';
import 'package:zhishu_card/Tools/SqliteTool.dart';
import '../Home/Models/HomeModel.dart';

const String isFIRSTLSUNCHAPP = "isFirstLaunchApp"; // 第一次打开app

class SharedTool {
  static var shared = SharedTool();

  // 全部任务
  void sharedAllTask() async {}

  // 今天任务读取
  Future<List> sharedReadCurrentTask() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    final str = shared.getString("currentTask");
    if (str == null) {
      return [];
    }
    // 字符串转list
    List m = JSONTool.toClass(str);
    return m;
  }

  // 今天任务写入
  Future<String> sharedWriteCurrentTask(List<HomeModel> dataList) async {
    List<Map> list = [];
    for (var model in dataList) {
      Map c = model.toJson();
      list.add(c);
    }
    // list.forEach((element) {});
    final currentTaskString = JSONTool.toJSONString(list);
    SharedPreferences shared = await SharedPreferences.getInstance();
    final String str = shared.getString("currentTask");
    print("currentTaskString = $currentTaskString \nstr = $str");
    if (str == currentTaskString) {
      return "和上次没有改变,不需要写入";
    } else {
      shared.setString("currentTask", currentTaskString);
      return "写入成功";
    }
  }

  // 今天时间
  void sharedCurrentTime() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    DateTime time = DateTime.now();
    final nowDay = DateFormat("yyyy-MM-dd").format(time);
    final String saveDay = shared.getString("currentTime");
    // todo
    if (nowDay == saveDay) {
      print("时间和上次保存不同 $nowDay");
      shared.setString("currentTime", nowDay);
      // 数据库保存信息
      List l = await sharedReadCurrentTask();
      SqliteTool.insertFromYesterday(l, saveDay);
    } else {
      print("时间和上次保存相同 $nowDay");
    }
  }
}

class SharedToolUser extends SharedTool {
  // 第一次打开app,引导
  bool isFirstLaunchApp = true;

  // 是不是第一次打开app,引导
  void userPreferIsFirstLaunch() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    final isFirst = shared.getBool(isFIRSTLSUNCHAPP);
    if (!isFirst) {
      shared.setBool(isFIRSTLSUNCHAPP, false);
    }
    isFirstLaunchApp = isFirst;
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
