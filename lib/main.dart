import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhishu_card_flutter/Home/HomeViewController.dart';
import 'package:zhishu_card_flutter/Setting/SettingViewController.dart';
import 'package:zhishu_card_flutter/Tools/MainTool.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenUtil.init(constraints,
            designSize: Size(750, 1334), allowFontScaling: false);
        return MaterialApp(
          home: RootViewController(),
          theme: ThemeData(
            primaryColor: Colors.cyan,
            fontFamily: "PingFangSC",
          ),
        );
      },
    );
  }
}

class RootViewController extends StatefulWidget {
  @override
  _RootViewControllerState createState() => _RootViewControllerState();
}

class _RootViewControllerState extends State<RootViewController> {
  int _currentIndex = 0;
  List<Widget> pageList = [HomeViewController(), SettingViewController()];
  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    Widget scaf = Scaffold(
      body: PageView(
        pageSnapping: false, // 回弹
        physics: NeverScrollableScrollPhysics(), //
        children: pageList,
        controller: _pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: TextStyle(fontFamily: fontErasBold),
        selectedLabelStyle: TextStyle(fontFamily: fontErasBold),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "home"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "setting"),
        ],
        onTap: ((index) {
          _currentIndex = index;
          _pageController.jumpToPage(index);
          setState(() {});
        }),
        currentIndex: _currentIndex,
      ),
    );
    return scaf;
  }
}
