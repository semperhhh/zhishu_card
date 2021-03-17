import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:zhishu_card/Home/HomeCalendarVC.dart';
import 'package:zhishu_card/Home/Util/HomeModelUtil.dart';
import 'package:zhishu_card/Home/Views/HomeTopView.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/ThemeModel.dart';
import 'package:zhishu_card/Tools/UserPrefereTool.dart';
import '../Tools/ColorUtil.dart';
import 'Models/HomeModel.dart';
import 'Views/HomeTableViewCell.dart';
import '../Tools/UserPrefereTool.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// 主页
class HomeViewController extends StatefulWidget {
  @override
  _HomeViewControllerState createState() => _HomeViewControllerState();
}

class _HomeViewControllerState extends State<HomeViewController>
    with AutomaticKeepAliveClientMixin {
  @override
  // 混入 mixin 保存状态
  bool get wantKeepAlive => true;

  // 数据
  List<HomeModel> dataList;

  @override
  void initState() {
    super.initState();

    dataList = HomeModelUtil.shared.currentTaskList;
    print("_HomeViewControllerState - $dataList");

    // 第一次打开
    if (UserPrefereToolFirst.isFirstLaunchApp) {
      var m1 = HomeModel(UserPrefereTool.sharedTaskId(), "英语单词", 30);
      var m2 = HomeModel(UserPrefereTool.sharedTaskId(), "数学习题", 100,
          isDone: true, descriptionString: "💻任务完成后可以长按添加记录心情");

      // 更新偏好
      HomeModelUtil.shared.currentTaskList.addAll([m1, m2]);
      HomeModelUtil.shared.allTaskList.addAll([m1, m2]);
      UserPrefereToolFirst.userSaveTimeFirstLaunch();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("123");
    return Scaffold(
      body: Column(
        children: [_bodyView(context)],
      ),
    );
  }

  Widget _bodyView(BuildContext context) {
    return Expanded(
      child: Container(
        color: ThemeModel.isDarkMode(context)
            ? ColorUtil.main_dark_app
            : Colors.white,
        child: Obx(() {
          return ListView.builder(
              itemBuilder: (context, index) => _itemBuilder(context, index),
              itemCount: dataList.length + 1);
        }),
      ),
    );
  }

  // cell
  Widget _itemBuilder(BuildContext context, int index) {
    print("_itemBuilder");
    if (index == 0) {
      return HomeTopView();
    } else {
      return HomeTableViewCell(
        model: dataList[index - 1],
        didSetCallback: () {
          // 更新数据库
        },
      );
    }
  }
}
