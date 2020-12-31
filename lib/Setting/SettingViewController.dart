import 'package:flutter/material.dart';
import 'package:zhishu_card_flutter/Setting/SettingAboutVC.dart';
import 'package:zhishu_card_flutter/Setting/SettingSendVC.dart';
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
        title: Text("设置"),
      ),
      body: SettingInheritedWidget(
        index: 0,
        child: Container(
          color: ColorUtil.grey,
          child: Column(
            children: [
              SettingTopView(),
              SizedBox(height: 40),
              SettingViewCell(name: "推送设置"),
              SettingViewCell(name: "关于"),
              SettingViewCell(name: "退出登录", color: ColorUtil.green)
            ],
          ),
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
          if (name == "退出登录") {
            print("exit -- ");
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
