import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:zhishu_card/Home/Models/HomeModel.dart';
import 'package:zhishu_card/Home/Util/HomeModelUtil.dart';
import 'package:zhishu_card/Tools/FileUtil.dart';
import 'package:zhishu_card/Tools/SqliteTool.dart';
import '../Home/Models/HomeModel.dart';
import 'JSONTool.dart';

// 用户工具类
const String ISFIRSTLSUNCHAPP = "isFirstLaunchApp"; // 第一次打开app
const String CURRENTTIME = "currentTime"; // 当前时间
const String CURRENTTASK = "currentTask"; // 当前任务
const String ALLTASK = "allTask"; // 全部任务
const String TASKID = "taskId"; // 任务id
const String NAME = "name"; // 昵称
const String DESC = "desc"; // 目标
const String FIGHTING = "fighting"; // 鸡汤
const String APPEARANCETYPE = "appearanceType"; // 外观

class UserPrefereTool {
  static SharedPreferences _pres;
  static int _taskId = _pres.getInt(TASKID) ?? 0;
  static String name = _pres.getString(NAME) ?? "昵称";
  static String desc = _pres.getString(DESC) ?? "目标";
  static String fighting =
      _pres.getString(FIGHTING) ?? "今天也要fighting!(点击修改激励语)";
  static int appearanceType = _pres.getInt(APPEARANCETYPE) ?? 0;
  // 今天任务
  static String currentTask = _pres.getString(CURRENTTASK);
  // 全部任务
  static String allTask = _pres.getString(ALLTASK);

  // init
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

  static ThemeMode currentThemeMode() {
    switch (appearanceType) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      default:
        return ThemeMode.dark;
    }
  }

  static changeThemeMode(int type) {
    _pres.setInt(APPEARANCETYPE, type);
  }

  // 读-全部任务
  static Future<List> sharedReadAllTask() async {
    if (allTask == null) {
      return [];
    }
    List l = JSONTool.toClass(allTask);
    return l;
  }

  // 写-全部任务
  static Future<bool> sharedWriteAllTask() async {
    List<Map> list = [];
    for (var model in HomeModelUtil.shared.allTaskList) {
      HomeModel m = HomeModel.fromJson(model.toJson());
      m.isDone = false;
      m.descriptionString = "";
      Map c = m.toJson();
      list.add(c);
    }
    final allTaskString = JSONTool.toJSONString(list);
    // print("allTaskString = $allTaskString \nstr = $str");
    if (allTask == allTaskString) {
      print("和上次没有改变,不需要写入");
      return false;
    } else {
      _pres.setString(ALLTASK, allTaskString);
      print("写入成功 - 全部任务");
      allTask = allTaskString;
      return true;
    }
  }

  // 读-今天任务
  static Future<List> sharedReadCurrentTask() async {
    if (currentTask == null) {
      return [];
    }
    // 字符串转list
    List l = JSONTool.toClass(currentTask);
    return l;
  }

  // 写-今天任务
  static Future<bool> sharedWriteCurrentTask() async {
    List<Map> list = [];
    for (var model in HomeModelUtil.shared.currentTaskList) {
      Map c = model.toJson();
      list.add(c);
    }
    final currentTaskString = JSONTool.toJSONString(list);
    // print("currentTaskString = $currentTaskString \nstr = $currentTask");
    if (currentTask == currentTaskString) {
      print("和上次没有改变,不需要写入");
      return false;
    } else {
      _pres.setString(CURRENTTASK, currentTaskString);
      print("写入成功 - 今天任务");
      currentTask = currentTaskString;
      return true;
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

extension UserPrefereToolLogin on UserPrefereTool {
  // 退出清除数据
  static void exit() {
    UserPrefereTool._pres.setString(NAME, "");
    UserPrefereTool._pres.setString(DESC, "");
    HomeModelUtil.shared.currentTaskList.value = [];
    HomeModelUtil.shared.allTaskList.value = [];
    FileUtil.deleteLocalFile("head.png");
  }

  static void login(String nickName) {
    print("登录设置名字 - $nickName");
    UserPrefereTool._pres.setString(NAME, nickName);
    UserPrefereTool.name = nickName;
  }

  // 是否有名字(登录过)
  static bool isName() {
    String name = UserPrefereTool.name;
    if (name == "" || name == null) {
      return false;
    } else {
      return true;
    }
  }
}

class UserModel extends ChangeNotifier {
  String get name => UserPrefereTool.name;
  String get desc => UserPrefereTool.desc;
  String get fighting => UserPrefereTool.fighting;

  set name(String str) {
    if (name != str) {
      UserPrefereTool.name = str;
      UserPrefereTool._pres.setString(NAME, name);
      notifyListeners();
    }
  }

  set desc(String str) {
    if (desc != str) {
      UserPrefereTool.desc = str;
      UserPrefereTool._pres.setString(DESC, desc);
      notifyListeners();
    }
  }

  set fighting(String str) {
    if (fighting != str) {
      UserPrefereTool.fighting = str;
      UserPrefereTool._pres.setString(FIGHTING, fighting);
      notifyListeners();
    }
  }
}
