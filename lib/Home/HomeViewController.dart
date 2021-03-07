import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:provider/provider.dart';
import 'package:zhishu_card/Custom/PopView/PHPopDialog.dart';
import 'package:zhishu_card/Home/HomeCalendarVC.dart';
import 'package:zhishu_card/Home/Util/HomeModelUtil.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/MainTool.dart';
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
        children: [
          SizedBox(
              height: ScreenUtil().statusBarHeight,
              child: Container(
                color: ThemeModel.isDarkMode(context)
                    ? ColorUtil.main_dark_app
                    : ColorUtil.grey,
              )),
          // _topView(),
          _bodyView(context)
        ],
      ),
    );
  }

  Widget _bodyView(BuildContext context) {
    return Expanded(
      child: Container(
        color: ThemeModel.isDarkMode(context)
            ? ColorUtil.main_dark_app
            : ColorUtil.grey,
        child: Obx(() {
          return ListView.builder(
              padding:
                  EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
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
      return _topView(context);
    } else {
      return HomeTableViewCell(
        model: dataList[index - 1],
        didSetCallback: () {
          // 更新数据库
        },
      );
    }
  }

  Widget _topView(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return ConstrainedBox(
        constraints: BoxConstraints(minHeight: 160),
        child: Container(
            padding: EdgeInsets.only(bottom: 8),
            width: 375.sw,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text("任务",
                          style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: fontMedium,
                              color: ThemeModel.isDarkMode(context)
                                  ? ColorUtil.main_light_app
                                  : ColorUtil.main_dark_app)),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onLongPress: () {
                        print("长按");
                        showFightingChangeDialogView(
                                context: context, currentStr: user.fighting)
                            .then((value) {
                          user.fighting = value;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 8, right: 115),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: 66),
                          child: Text(
                            user.fighting,
                            style: TextStyle(
                                fontSize: 18.sp, fontFamily: fontKuaile),
                          ),
                        ),
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
