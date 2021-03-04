import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zhishu_card/Login/LoginViewController.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/Global.dart';
import 'package:zhishu_card/Tools/ThemeModel.dart';
import 'package:zhishu_card/Tools/UserPrefereTool.dart';
import '../SettingAboutVC.dart';
import '../SettingSendVC.dart';
import '../SettingAppearanceVC.dart';
import 'package:get/get.dart';

class SettingViewCell extends StatefulWidget {
  String name;
  Color color;
  SettingViewCell({Key key, @required this.name, this.color}) : super(key: key);
  @override
  _SettingViewCellState createState() => _SettingViewCellState();
}

class _SettingViewCellState extends State<SettingViewCell> {
  @override
  Widget build(BuildContext context) {
    // bool isDark = ;
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
          } else if (name == "推送") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingSendVC()));
          } else if (name == "关于") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingAboutVC()));
          } else if (name == "外观") {
            Get.to(SettingAppearanceVC());
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
              color: widget.color != null
                  ? widget.color
                  : (ThemeModel.isDarkMode(context)
                      ? ColorUtil.main_dark1_app
                      : Colors.white),
              borderRadius: BorderRadius.circular(8)),
        ));
    return gesture;
  }
}
