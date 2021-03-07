import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/Global.dart';
import 'package:zhishu_card/Tools/ThemeModel.dart';
import 'Views/SettingTopView.dart';
import 'Views/SettingViewCell.dart';
import 'package:get/get.dart';

// 数据共享
class SettingInheritedWidget extends InheritedWidget {
  final int index;
  SettingInheritedWidget(
      {Key key, @required Widget child, @required this.index})
      : super(key: key, child: child);

  static SettingInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SettingInheritedWidget>();
  }

  @override
  bool updateShouldNotify(SettingInheritedWidget oldWidget) {
    return oldWidget.index != index;
  }
}

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
      appBar: AppBar(
        title: Text(
          "设置",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: SettingInheritedWidget(
        index: 0,
        child: Container(
            color: ThemeModel.isDarkMode(context)
                ? ColorUtil.main_dark_app
                : ColorUtil.grey,
            child: ListView(children: [
              SettingTopView(),
              SizedBox(height: 40),
              // SettingViewCell(name: "推送"),
              SettingViewCell(name: "外观"),
              SettingViewCell(name: "关于"),
              SettingViewCell(name: "重新开始", color: ColorUtil.main_app)
            ])),
      ),
    );
  }

  @override
  // 混入 mixin 保存状态
  bool get wantKeepAlive => true;
}
