import 'package:zhishu_card/Home/Models/HomeModel.dart';
import 'package:get/get.dart';
import 'package:zhishu_card/Tools/UserPrefereTool.dart';

class HomeModelUtil {
  // 当天任务
  static RxList<HomeModel> currentTaskList = <HomeModel>[].obs;
  // 全部任务
  static RxList<HomeModel> allTaskList = <HomeModel>[].obs;

  // 初始化
  static init() async {
    UserPrefereTool.sharedReadAllTask().then((list) {
      allTaskList.value = list.map((e) => HomeModel.fromJson(e)).toList();
    });

    // 判断时间,是不是保存昨天的
    if (UserPrefereTool.sharedTimeIsToday() == true) {
      UserPrefereTool.sharedReadCurrentTask().then((list) {
        currentTaskList.value = list.map((e) => HomeModel.fromJson(e)).toList();
        print("今天 - 读取数据");
      });
    } else {
      // 昨天,保存数据,读新数据
      UserPrefereTool.sharedSaveDataFromSqlite();
      UserPrefereTool.sharedReadAllTask().then((list) {
        currentTaskList.value = list.map((e) => HomeModel.fromJson(e)).toList();
        print("昨天,保存数据,读新数据 - 写入今天的数据");
        UserPrefereTool.sharedWriteCurrentTask(currentTaskList);
      });
    }
  }
}
