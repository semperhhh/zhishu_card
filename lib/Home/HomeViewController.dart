import 'package:flutter/material.dart';
import 'package:zhishu_card_flutter/Tools/MainTool.dart';

// 主页
class HomeViewController extends StatefulWidget {
  @override
  _HomeViewControllerState createState() => _HomeViewControllerState();
}

class _HomeViewControllerState extends State<HomeViewController> {
  // 数据
  List<String> dataList = ["1", "2", "3", "4"];

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
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Text(dataList[index]);
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
