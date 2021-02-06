import 'package:flutter/material.dart';
import 'package:zhishu_card/Home/HomeCalendarVC.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/UserPrefereTool.dart';
import '../Tools/ColorUtil.dart';
import 'Models/HomeModel.dart';
import 'Views/HomeTableViewCell.dart';
import '../Tools/UserPrefereTool.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  List<HomeModel> dataList = [];

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
      UserPrefereTool.sharedWriteCurrentTask(l);
      UserPrefereTool.sharedWriteAllTask(l);
      UserPrefereToolFirst.userSaveTimeFirstLaunch();
    }

    // 判断时间,是不是保存昨天的
    if (UserPrefereTool.sharedTimeIsToday() == true) {
      // 今天,读已有数据
      UserPrefereTool.sharedReadCurrentTask().then((list) {
        // list转model
        list.forEach((element) {
          HomeModel model = HomeModel.fromJson(element);
          dataList.add(model);
        });
        setState(() {});
      }); // 任务
    } else {
      // 昨天,保存数据,读新数据
      UserPrefereTool.sharedSaveDataFromSqlite();
      UserPrefereTool.sharedReadAllTask().then((list) {
        list.forEach((element) {
          HomeModel model = HomeModel.fromJson(element);
          dataList.add(model);
        });
        // dataList = list.map((e) => HomeModel.fromJson(e));
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(children: [
          SizedBox(
              height: ScreenUtil().statusBarHeight,
              child: Container(color: ColorUtil.grey)),
          // _topView(),
          _bodyView()
        ]),
      );

  Widget _bodyView() {
    return Expanded(
        child: Container(
            color: ColorUtil.grey,
            child: ListView.builder(
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                itemBuilder: (context, index) => _itemBuilder(context, index),
                itemCount: dataList.length + 1)));
  }

  // cell
  Widget _itemBuilder(BuildContext context, int index) {
    if (index == 0) {
      return _topView();
    } else {
      return HomeTableViewCell(
        model: dataList[index - 1],
        didSetCallback: () {
          // 更新偏好
          UserPrefereTool.sharedWriteCurrentTask(dataList).then((value) {
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
                          "今天的鸡汤d哦哦飞机搜房解耦佛建瓯市就佛教佛山接of解耦司法局噢司法局OS董事局佛山金佛山金佛的解耦福建省",
                          style: TextStyle(fontSize: 18.sp)),
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
