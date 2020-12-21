import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhishu_card_flutter/Tools/mainTool.dart';
import 'Views/SettingTopView.dart';

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
  int _currentIndex = 0;

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
        title: Text(
          "setting",
          style: TextStyle(fontFamily: fontErasBold),
        ),
      ),
      body: SettingInheritedWidget(
          child: Column(
        children: [
          SettingTopView(),
          Row(
            children: [
              Text("推送设置"),
            ],
          ),
          Row(
            children: [
              Text("关于质数任务"),
            ],
          ),
          Row(
            children: [
              Text("退出登录"),
            ],
          ),
        ],
      )),
    );
  }

  @override
  // 混入 mixin 保存状态
  bool get wantKeepAlive => true;
}
