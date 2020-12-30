import 'package:flutter/material.dart';
import 'package:zhishu_card_flutter/Tools/MainTool.dart';

class HomeAddVC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add task", style: TextStyle(fontFamily: fontErasBold)),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add_to_photos,
              color: Colors.white,
            ),
            onPressed: () {
              print("点击了添加");
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Container(
        child: Text("添加任务"),
      ),
    );
  }
}
