import 'package:flutter/material.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';

class SettingAboutVC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于"),
      ),
      backgroundColor: ColorUtil.grey,
      body: Container(
        margin: EdgeInsets.only(top: 15, left: 15, right: 15),
        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Text("""
💻质数任务是一款个人开发的App,希望帮助大家管理时间,克服一点点的拖延症.

🍷如果质数任务对你有一点点的帮助,非常感谢!!!

🍔现在是2020年12月31日,2021新年快乐!
        """, style: TextStyle(fontSize: 17)),
      ),
    );
  }
}
