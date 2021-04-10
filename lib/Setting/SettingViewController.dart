import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zhishu_card/Login/LoginViewController.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/ThemeModel.dart';
import 'package:zhishu_card/Tools/UserPrefereTool.dart';
import 'SettingAboutVC.dart';
import 'SettingAppearanceVC.dart';
import 'SettingSendVC.dart';
import 'Views/SettingTopView.dart';
import 'Views/SettingViewCell.dart';

// 设置
class SettingViewController extends StatefulWidget {
  @override
  _SettingViewControllerState createState() => _SettingViewControllerState();
}

class _SettingViewControllerState extends State<SettingViewController>
    with AutomaticKeepAliveClientMixin {
  // 周报通道
  MethodChannel _methodChannel = MethodChannel("report_page");
  @override
  void initState() {
    super.initState();
    print("_SettingViewControllerState");
    _methodChannel.setMethodCallHandler((call) {
      print("周报回调");
    });
  }

  @override
  void dispose() {
    super.dispose();
    print("settingViewController dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ThemeModel.isDarkMode(context)
            ? ColorUtil.main_dark_app
            : Colors.white,
        child: Wrap(
          // direction: Axis.vertical,
          children: <Widget>[
            SettingTopView(),
            SizedBox(height: 20),
            SettingViewCell(
              name: "外观",
              iconName: "asset/images/setting_send.png",
              callback: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SettingAppearanceVC()));
              },
            ),
            SettingViewCell(
              name: "周报",
              iconName: "asset/images/setting_send.png",
              callback: () {
                _methodChannel.invokeMethod("report_page_push");
              },
            ),
            // SettingViewCell(
            //   name: "推送",
            //   iconName: "asset/images/setting_about.png",
            //   callback: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => SettingSendVC()));
            //   },
            // ),
            SettingViewCell(
              name: "关于",
              iconName: "asset/images/setting_about.png",
              callback: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingAboutVC()));
              },
            ),
            SettingViewCell(
              name: "重新开始",
              iconName: "asset/images/setting_exit.png",
              callback: () {
                print("exit -- ");
                UserPrefereToolLogin.exit();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (buildContext) => LoginViewController(),
                      fullscreenDialog: true),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  // 混入 mixin 保存状态
  bool get wantKeepAlive => true;
}
