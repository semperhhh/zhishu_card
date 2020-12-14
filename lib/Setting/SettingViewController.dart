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
    var floatingActionButton2 = FloatingActionButton.extended(
      onPressed: () {
        setState(() {
          _currentIndex += 1;
          print("currentIndex - $widget.currentIndex");
        });
      },
      label: Icon(Icons.add),
      backgroundColor: Colors.red,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "setting",
          style: TextStyle(fontFamily: fontErasBold),
        ),
      ),
      body: SettingInheritedWidget(
          child: Row(
            children: [SettingTopView()],
          ),
          index: _currentIndex),
      floatingActionButton: floatingActionButton2,
    );
  }

  @override
  // 混入 mixin 保存状态
  bool get wantKeepAlive => true;
}
