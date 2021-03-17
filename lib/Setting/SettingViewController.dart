import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/Global.dart';
import 'package:zhishu_card/Tools/ThemeModel.dart';
import 'Views/SettingTopView.dart';
import 'Views/SettingViewCell.dart';

// 设置
class SettingViewController extends StatefulWidget {
  @override
  _SettingViewControllerState createState() => _SettingViewControllerState();
}

class _SettingViewControllerState extends State<SettingViewController>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    print("_SettingViewControllerState");
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
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            SettingTopView(),
            SizedBox(height: 20),
            SettingViewCell(
              name: "关于",
              iconName: "asset/images/setting_about.png",
            ),
            // SettingViewCell(name: "推送"),
            SettingViewCell(
              name: "外观",
              iconName: "asset/images/setting_send.png",
            ),
            SettingViewCell(
              name: "重新开始",
              iconName: "asset/images/setting_exit.png",
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
