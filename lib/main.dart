import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhishu_card/Home/HomeViewController.dart';
import 'package:zhishu_card/Setting/SettingViewController.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/MainTool.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:zhishu_card/Tools/SqliteTool.dart';

main(List<String> args) {
  initializeDateFormatting().then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenUtil.init(constraints,
            designSize: Size(375, 667), allowFontScaling: false);
        return MaterialApp(
            home: RootViewController(),
            theme: ThemeData(
                platform: TargetPlatform.iOS,
                // brightness: Brightness.light, // 主题颜色
                primaryColor: ColorUtil.styleGreen,
                appBarTheme: AppBarTheme(
                    color: ColorUtil.styleGreen, shadowColor: Colors.white),
                fontFamily: fontPingFange,
                splashColor: Colors.transparent, // 水波纹
                highlightColor: Colors.transparent));
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
          selectedFontSize: 12,
          unselectedLabelStyle: TextStyle(fontFamily: fontErasBold),
          selectedLabelStyle: TextStyle(fontFamily: fontErasBold),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "setting"),
          ],
          onTap: ((index) {
            _currentIndex = index;
            _pageController.jumpToPage(index);
            setState(() {});
          }),
          currentIndex: _currentIndex,
        ));
    return scaf;
  }
}
