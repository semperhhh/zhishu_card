import 'package:zhishu_card/Home/Models/HomeModel.dart';
import 'package:get/get.dart';
import 'package:zhishu_card/Tools/UserPrefereTool.dart';

class HomeModelUtil extends GetxController {
  @override
  void onInit() {
    super.onInit();

    UserPrefereTool.sharedReadAllTask().then((list) {
      shared.allTaskList
          .addAll(list.map((e) => HomeModel.fromJson(e)).toList());
    });

    // 判断时间,是不是保存昨天的
    if (UserPrefereTool.sharedTimeIsToday() == true) {
      UserPrefereTool.sharedReadCurrentTask().then((list) {
        shared.currentTaskList
            .addAll(list.map((e) => HomeModel.fromJson(e)).toList());
        print("今天 - 读取数据");
      });
    } else {
      // 昨天,保存数据,读新数据
      UserPrefereTool.sharedSaveDataFromSqlite();
      UserPrefereTool.sharedReadAllTask().then((list) {
        shared.currentTaskList
            .addAll(list.map((e) => HomeModel.fromJson(e)).toList());
        print(
            "昨天,保存数据,读新数据 - 写入今天的数据 currentTaskList = ${shared.currentTaskList}");
        UserPrefereTool.sharedWriteCurrentTask();
      });
    }

    // 变化时调用
    ever(currentTaskList, (_) {
      print("变化时调用 - homeModelUtil.currentTaskList");
      UserPrefereTool.sharedWriteCurrentTask();
    });
    ever(allTaskList, (_) {
      print("变化时调用 - homeModelUtil.allTaskList");
      UserPrefereTool.sharedWriteAllTask();
    });
  }

  static HomeModelUtil shared = Get.put(HomeModelUtil());
  // 当天任务
  RxList<HomeModel> currentTaskList = <HomeModel>[].obs;
  // 全部任务
  RxList<HomeModel> allTaskList = <HomeModel>[].obs;
}
