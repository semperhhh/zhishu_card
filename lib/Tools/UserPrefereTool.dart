// 分享工具类

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:zhishu_card/Home/Models/HomeModel.dart';
import 'package:zhishu_card/Tools/SqliteTool.dart';
import '../Home/Models/HomeModel.dart';

const String ISFIRSTLSUNCHAPP = "isFirstLaunchApp"; // 第一次打开app
const String CURRENTTIME = "currentTime"; // 当前时间
const String CURRENTTASK = "currentTask"; // 当前任务
const String ALLTASK = "allTask"; // 全部任务
const String TASKID = "taskId"; // 任务id

class UserPrefereTool {
  static SharedPreferences _pres;

  static int _taskId = _pres.getInt("TASKID") ?? 0;

  static Future init() async {
    _pres = await SharedPreferences.getInstance();
    UserPrefereToolFirst.isFirstLaunch();
    print("userPreferences load success ---- ");
  }

  // 任务id + 1
  static int sharedTaskId() {
    _taskId += 1;
    _pres.setInt(TASKID, _taskId);
    return _taskId;
  }

  // 读-全部任务
  static Future<List> sharedReadAllTask() async {
    final str = _pres.getString(ALLTASK);
    if (str == null) {
      return [];
    }
    List l = JSONTool.toClass(str);
    return l;
  }

  // 写-全部任务
  static Future sharedWriteAllTask(List<HomeModel> dataList) async {
    List<Map> list = [];
    for (var model in dataList) {
      model.isDone = false;
      model.descriptionString = "";
      Map c = model.toJson();
      list.add(c);
    }
    final allTaskString = JSONTool.toJSONString(list);
    final String str = _pres.getString(ALLTASK);
    print("allTaskString = $allTaskString \nstr = $str");
    if (str == allTaskString) {
      return "和上次没有改变,不需要写入";
    } else {
      _pres.setString(ALLTASK, allTaskString);
      return "写入成功";
    }
  }

  // 读-今天任务
  static Future<List> sharedReadCurrentTask() async {
    final str = _pres.getString(CURRENTTASK);
    if (str == null) {
      return [];
    }
    // 字符串转list
    List l = JSONTool.toClass(str);
    return l;
  }

  // 写-今天任务
  static Future<String> sharedWriteCurrentTask(List<HomeModel> dataList) async {
    List<Map> list = [];
    for (var model in dataList) {
      Map c = model.toJson();
      list.add(c);
    }
    final currentTaskString = JSONTool.toJSONString(list);
    final String str = _pres.getString(CURRENTTASK);
    print("currentTaskString = $currentTaskString \nstr = $str");
    if (str == currentTaskString) {
      return "和上次没有改变,不需要写入";
    } else {
      _pres.setString(CURRENTTASK, currentTaskString);
      return "写入成功";
    }
  }

  // 判断上次打开是否今天(时间保存相同)
  static bool sharedTimeIsToday() {
    DateTime time = DateTime.now();
    final nowDay = DateFormat("yyyy-MM-dd").format(time);
    final String saveDay = _pres.getString(CURRENTTIME);
    // todo
    if (nowDay != saveDay) {
      print("时间和上次保存不同 $nowDay");
      _pres.setString("currentTime", nowDay);
      return false;
    } else {
      print("时间和上次保存相同 $nowDay");
      return true;
    }
  }

  // 保存昨天的数据到数据库
  static void sharedSaveDataFromSqlite() async {
    final String saveDay = _pres.getString(CURRENTTIME);
    if (saveDay == null) {
      return;
    }
    // 数据库保存信息
    List l = await sharedReadCurrentTask();
    SqliteToolTask.insertFromYesterday(l, saveDay);
  }
}

extension UserPrefereToolSecond on UserPrefereTool {
  void sjfslfjslf() {}
}

extension UserPrefereToolFirst on UserPrefereTool {
  // 第一次打开app,引导
  static bool isFirstLaunchApp;

  // 是不是第一次打开app,引导
  static void isFirstLaunch() {
    final isFirst = UserPrefereTool._pres.getBool(ISFIRSTLSUNCHAPP);
    if (isFirst == null) {
      isFirstLaunchApp = true;
      UserPrefereTool._pres.setBool(ISFIRSTLSUNCHAPP, false);
    } else {
      isFirstLaunchApp = false;
    }
  }

  // 第一次保存时间
  static void userSaveTimeFirstLaunch() {
    DateTime time = DateTime.now();
    final nowDay = DateFormat("yyyy-MM-dd").format(time);
    UserPrefereTool._pres.setString(CURRENTTIME, nowDay);
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
