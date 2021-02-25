import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:zhishu_card/Home/HomeCalendarVC.dart';
import 'package:zhishu_card/Home/Util/HomeModelUtil.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
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
  List<HomeModel> dataList = HomeModelUtil.shared.currentTaskList;

  // 鸡汤
  String _fightingString;

  @override
  void initState() {
    super.initState();

    // 第一次打开
    if (UserPrefereToolFirst.isFirstLaunchApp) {
      final List<HomeModel> l = [
        HomeModel(UserPrefereTool.sharedTaskId(), "英语单词", 30),
        HomeModel(UserPrefereTool.sharedTaskId(), "数学习题", 100,
            isDone: true, descriptionString: "💻任务完成后可以长按添加记录心情")
      ];
      // 更新偏好
      HomeModelUtil.shared.currentTaskList.assignAll(l);
      HomeModelUtil.shared.allTaskList.assignAll(l);
      UserPrefereToolFirst.userSaveTimeFirstLaunch();
      UserPrefereToolLogin.setFighting("今天也要fighting!(点击修改激励语)");
    }

    _fightingString = UserPrefereToolLogin.getFighting() ?? "今天也要fighting!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
            height: ScreenUtil().statusBarHeight,
            child: Container(color: ColorUtil.grey)),
        // _topView(),
        _bodyView()
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          HomeModelUtil.shared.currentTaskList.value = [];
        },
        child: Text("update"),
      ),
    );
  }

  Widget _bodyView() {
    return Expanded(
        child: Container(
      color: ColorUtil.grey,
      child: Obx(() {
        return ListView.builder(
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
            itemBuilder: (context, index) => _itemBuilder(context, index),
            itemCount: dataList.length + 1);
      }),
    ));
  }

  // cell
  Widget _itemBuilder(BuildContext context, int index) {
    print("_itemBuilder");
    if (index == 0) {
      return _topView();
    } else {
      return HomeTableViewCell(
        model: dataList[index - 1],
        didSetCallback: () {
          // 更新偏好
          UserPrefereTool.sharedWriteCurrentTask().then((value) {
            print(value);
          });
          // 更新数据库
        },
      );
    }
  }

  Widget _topView() {
    return ConstrainedBox(
        constraints: BoxConstraints(minHeight: 160),
        child: Container(
            padding: EdgeInsets.only(bottom: 8),
            width: 375.sw,
            color: ColorUtil.grey,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text("任务", style: TextStyle(fontSize: 32.sp)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8, right: 115),
                      child: Text(
                        _fightingString,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 2,
                    right: 0,
                    child: Image.asset("asset/images/home_top.png",
                        width: 100, height: 100)),
              ],
            )));
  }
}
