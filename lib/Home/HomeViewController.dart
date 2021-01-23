import 'package:flutter/material.dart';
import 'package:zhishu_card/Home/HomeAddVC.dart';
import 'package:zhishu_card/Home/HomeCalendarVC.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/SharedTool.dart';
import 'package:zhishu_card/Tools/SqliteTool.dart';
import '../Tools/ColorUtil.dart';
import 'Models/HomeModel.dart';
import 'Views/HomeTableViewCell.dart';
import '../Tools/SharedTool.dart';
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
  List<HomeModel> dataList = [
    HomeModel(0, "英语单词", 30),
    HomeModel(1, "Swift底层", 150,
        isDone: true, descriptionString: "💻晚上22:22完成了Swift的学习,明天加油!"),
    HomeModel(2, "FlutterUI", 100,
        isDone: true, descriptionString: """🤚完成了第一章的学习
⌚️完成了第一章的练习题
🍐明天开始学习第二章
    """),
    HomeModel(3, "工作", 300, isDone: false),
  ];

  @override
  void initState() {
    super.initState();
    SharedTool.shared.sharedCurrentTime(); // 时间
    SharedTool.shared.sharedReadCurrentTask().then((str) {
      if (str == null) {
        return;
      }
      // 字符串转list
      List m = JSONTool.toClass(str);
      // list转model
      for (Map s in m) {
        HomeModel model = HomeModel.fromJson(s);
        print(model);
        dataList.add(model);
      }
      print(dataList.length);
      setState(() {});
    }); // 任务

    SqliteTool.openData().then((value) {
      
    });
    // 数据库操作
    // SqliteTool.insert();
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
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: FloatingActionButton.extended(
            label: Icon(Icons.add_alarm),
            onPressed: () {
              print("FloatingActionButton");
              Navigator.of(context).push(MaterialPageRoute(
                builder: (builderText) => HomeAddVC(),
                fullscreenDialog: true,
              ));
            }),
      );

  Widget _bodyView() {
    return Expanded(
        child: Container(
            color: ColorUtil.grey,
            child: ListView.builder(
                padding:
                    EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _topView();
                  } else {
                    return HomeTableViewCell(dataList[index - 1]);
                  }
                },
                itemCount: dataList.length + 1)));
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
                          "今天的鸡汤dfjOsdofjsofjoo哦哦飞机搜房解耦佛建瓯市就佛教佛山接of解耦司法局噢司法局OS董事局佛山金佛山金佛的解耦福建省",
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
