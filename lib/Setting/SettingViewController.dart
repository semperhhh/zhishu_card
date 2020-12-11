import 'package:flutter/material.dart';
import 'package:zhishu_card_flutter/Tools/mainTool.dart';

// 设置
class SettingViewController extends StatefulWidget {
  @override
  _SettingViewControllerState createState() => _SettingViewControllerState();
}

class _SettingViewControllerState extends State<SettingViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "setting",
          style: TextStyle(fontFamily: fontErasBold),
        ),
      ),
      body: Center(
        child: Text("设置"),
      ),
    );
  }
}
