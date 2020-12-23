import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zhishu_card_flutter/Tools/ColorUtil.dart';
import 'package:zhishu_card_flutter/Tools/MainTool.dart';

// 主页
class HomeViewController extends StatefulWidget {
  @override
  _HomeViewControllerState createState() => _HomeViewControllerState();
}

class _HomeViewControllerState extends State<HomeViewController> {
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
          padding: EdgeInsets.all(15),
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

// cell
class HomeTableViewCell extends StatefulWidget {
  final String name;
  // init
  HomeTableViewCell({Key key, @required this.name}) : super(key: key);
  @override
  _HomeTableViewCellState createState() => _HomeTableViewCellState();
}

class _HomeTableViewCellState extends State<HomeTableViewCell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorUtil.blue,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(1, 1),
                blurRadius: 3,
                spreadRadius: 2),
          ]),
      margin: EdgeInsets.only(top: 8, bottom: 10),
      height: 108,
      child: Row(
        children: [
          Text(widget.name + "12331231331231"),
          SizedBox(
            width: 10,
          ),
          Text(widget.name)
        ],
      ),
    );
  }
}
