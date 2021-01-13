import 'package:flutter/material.dart';
import 'package:zhishu_card/Home/HomeAddVC.dart';
import 'package:zhishu_card/Home/HomeCalendarVC.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/SharedTool.dart';
import '../Tools/ColorUtil.dart';
import 'Models/HomeModel.dart';
import 'Views/HomeTableViewCell.dart';

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
    HomeModel("英语单词", 30),
    HomeModel("Swift底层", 150,
        isDone: true, descriptionString: "💻晚上22:22完成了Swift的学习,明天加油!"),
    HomeModel("FlutterUI", 100, isDone: true, descriptionString: """🤚完成了第一章的学习
⌚️完成了第一章的练习题
🍐明天开始学习第二章
    """),
    HomeModel("工作", 300, isDone: false),
  ];

  @override
  void initState() {
    super.initState();
    SharedTool.shared.sharedCurrentTime();
    SharedTool.shared.sharedAllTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("任务"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.calendar_today,
                color: ColorUtil.blue,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (buildertext) {
                    return HomeCalendarVC();
                  },
                  fullscreenDialog: true,
                ));
              }),
        ],
      ),
      body: Container(
          color: ColorUtil.grey,
          child: ListView.builder(
              padding:
                  EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
              itemBuilder: (context, index) {
                return HomeTableViewCell(dataList[index]);
              },
              itemCount: dataList.length)),
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
  }
}
