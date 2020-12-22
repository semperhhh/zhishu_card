import 'package:flutter/material.dart';
import 'package:zhishu_card_flutter/Tools/ColorUtil.dart';
import 'package:zhishu_card_flutter/Tools/MainTool.dart';
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
        index: 0,
        child: Column(
          children: [
            SettingTopView(),
            SizedBox(height: 55),
            SettingViewCell(name: "推送设置", color: ColorUtil.red),
            SettingViewCell(name: "关于", color: ColorUtil.orange),
            SettingViewCell(name: "退出登录", color: ColorUtil.green),
          ],
        ),
      ),
    );
  }

  @override
  // 混入 mixin 保存状态
  bool get wantKeepAlive => true;
}

class SettingViewCell extends StatefulWidget {
  String name;
  Color color;
  SettingViewCell({Key key, @required this.name, @required this.color});
  @override
  _SettingViewCellState createState() => _SettingViewCellState();
}

class _SettingViewCellState extends State<SettingViewCell> {
  @override
  Widget build(BuildContext context) {
    var gesture = GestureDetector(
        onTap: () {
          print("gesture -- ${widget.name}");
        },
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 20),
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
