import 'package:flutter/material.dart';
import 'package:zhishu_card/Login/LoginViewController.dart';
import 'package:zhishu_card/Tools/UserPrefereTool.dart';

import '../SettingAboutVC.dart';
import '../SettingSendVC.dart';

class SettingViewCell extends StatefulWidget {
  String name;
  Color color;
  SettingViewCell({Key key, @required this.name, this.color = Colors.white})
      : super(key: key);
  @override
  _SettingViewCellState createState() => _SettingViewCellState();
}

class _SettingViewCellState extends State<SettingViewCell> {
  @override
  Widget build(BuildContext context) {
    var gesture = GestureDetector(
        onTap: () {
          final name = widget.name;
          if (name == "重新开始") {
            print("exit -- ");
            UserPrefereToolLogin.exit();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (buildContext) => LoginViewController(),
                  fullscreenDialog: true),
            );
          } else if (name == "推送设置") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingSendVC()));
          } else if (name == "关于") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingAboutVC()));
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
          height: 64,
          child: Center(
            child: Text(
              widget.name,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          decoration: BoxDecoration(
              color: widget.color, borderRadius: BorderRadius.circular(8)),
        ));
    return gesture;
  }
}
