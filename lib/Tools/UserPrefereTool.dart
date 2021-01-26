// 分享工具类

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:zhishu_card/Home/Models/HomeModel.dart';
import 'package:zhishu_card/Tools/SqliteTool.dart';
import '../Home/Models/HomeModel.dart';

const String isFIRSTLSUNCHAPP = "isFirstLaunchApp"; // 第一次打开app

class UserPrefereTool {
  static SharedPreferences _pres;

  static Future init() async {
    _pres = await SharedPreferences.getInstance();
    UserPrefereToolUser.isFirstLaunch();
    print("userPreferences load success ---- ");
  }

  // 全部任务
  void sharedAllTask() async {}

  // 今天任务读取
  static Future<List> sharedReadCurrentTask() async {
    final str = _pres.getString("currentTask");
    if (str == null) {
      return [];
    }
    // 字符串转list
    List m = JSONTool.toClass(str);
    return m;
  }

  // 今天任务写入
  static Future<String> sharedWriteCurrentTask(List<HomeModel> dataList) async {
    List<Map> list = [];
    for (var model in dataList) {
      Map c = model.toJson();
      list.add(c);
    }
    final currentTaskString = JSONTool.toJSONString(list);
    final String str = _pres.getString("currentTask");
    print("currentTaskString = $currentTaskString \nstr = $str");
    if (str == currentTaskString) {
      return "和上次没有改变,不需要写入";
    } else {
      _pres.setString("currentTask", currentTaskString);
      return "写入成功";
    }
  }

  // 今天时间
  static void sharedCurrentTime() async {
    DateTime time = DateTime.now();
    final nowDay = DateFormat("yyyy-MM-dd").format(time);
    final String saveDay = _pres.getString("currentTime");
    // todo
    if (nowDay != saveDay) {
      print("时间和上次保存不同 $nowDay");
      _pres.setString("currentTime", nowDay);
      if (saveDay == null) {
        return;
      }
      // 数据库保存信息
      List l = await sharedReadCurrentTask();
      SqliteTool.insertFromYesterday(l, saveDay);
    } else {
      print("时间和上次保存相同 $nowDay");
    }
  }
}

class UserPrefereToolUser extends UserPrefereTool {
  // 第一次打开app,引导
  static bool isFirstLaunchApp;

  // 是不是第一次打开app,引导
  static void isFirstLaunch() {
    final isFirst = UserPrefereTool._pres.getBool(isFIRSTLSUNCHAPP);
    if (isFirst == null) {
      isFirstLaunchApp = true;
      UserPrefereTool._pres.setBool(isFIRSTLSUNCHAPP, false);
    } else {
      isFirstLaunchApp = false;
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
