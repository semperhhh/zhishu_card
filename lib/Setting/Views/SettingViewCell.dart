import 'package:flutter/material.dart';
import 'package:zhishu_card/Login/LoginViewController.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/ThemeModel.dart';
import 'package:zhishu_card/Tools/UserPrefereTool.dart';
import '../SettingAboutVC.dart';
import '../SettingSendVC.dart';
import '../SettingAppearanceVC.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingViewCell extends StatefulWidget {
  String name;
  String iconName;
  SettingViewCell({Key key, @required this.name, @required this.iconName})
      : super(key: key);
  @override
  _SettingViewCellState createState() => _SettingViewCellState();
}

class _SettingViewCellState extends State<SettingViewCell> {
  @override
  Widget build(BuildContext context) {
    Widget contentView = Container(
      height: 64,
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: <Widget>[
          Positioned(
            left: 20,
            child: Image.asset(
              widget.iconName,
              width: 24,
              height: 24,
            ),
          ),
          Positioned(
            left: 64,
            child: Text(
              widget.name,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            right: 20,
            child: Image.asset("asset/images/setting_arrows.png"),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: (ThemeModel.isDarkMode(context)
            ? ColorUtil.main_dark1_app
            : Colors.white),
      ),
    );

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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SettingAppearanceVC()));
          }
        },
        child: contentView);
    return gesture;
  }
}
