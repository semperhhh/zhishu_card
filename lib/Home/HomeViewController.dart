import 'package:flutter/material.dart';
import 'package:zhishu_card_flutter/Tools/ColorUtil.dart';
import 'package:zhishu_card_flutter/Tools/MainTool.dart';

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
  List<String> dataList = ["1", "2", "3", "4", "5", "6"];

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
            return HomeTableViewCell(name: index.toString());
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
