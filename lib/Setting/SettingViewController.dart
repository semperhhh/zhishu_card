import 'package:flutter/material.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/ThemeTool.dart';
import 'Views/SettingTopView.dart';
import 'Views/SettingViewCell.dart';

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
        title: Text("设置", style: TextStyle(color: Colors.white)),
      ),
      body: SettingInheritedWidget(
        index: 0,
        child: Container(
            color: ThemeTool.isDark(context)
                ? ColorUtil.main_dark_app
                : ColorUtil.grey,
            child: ListView(children: [
              SettingTopView(),
              SizedBox(height: 40),
              SettingViewCell(
                  name: "推送设置",
                  color: ThemeTool.isDark(context)
                      ? ColorUtil.main_dark1_app
                      : Colors.white),
              SettingViewCell(
                  name: "关于",
                  color: ThemeTool.isDark(context)
                      ? ColorUtil.main_dark1_app
                      : Colors.white),
              SettingViewCell(name: "重新开始", color: ColorUtil.main_app)
            ])),
      ),
    );
  }

  @override
  // 混入 mixin 保存状态
  bool get wantKeepAlive => true;
}
