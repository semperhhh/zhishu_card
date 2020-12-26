import 'package:flutter/material.dart';
import 'package:zhishu_card_flutter/Tools/ColorUtil.dart';
import 'package:zhishu_card_flutter/Tools/MainTool.dart';
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
    HomeModel("Swift底层", 150, isDone: true),
    HomeModel("FlutterUI", 100, isDone: true),
    HomeModel("工作", 300, isDone: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "home",
          style: TextStyle(fontFamily: fontErasBold),
        ),
      ),
      body: Container(
        color: ColorUtil.grey,
        child: ListView.builder(
          padding: EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
          itemBuilder: (context, index) {
            return HomeTableViewCell(dataList[index]);
          },
          itemCount: dataList.length,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Icon(Icons.add_alarm),
        onPressed: () {
          print("FloatingActionButton");
        },
        backgroundColor: Colors.blue,
      ),
    );
  }
}
