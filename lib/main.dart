import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhishu_card/Home/HomeCalendarVC.dart';
import 'package:zhishu_card/Home/HomeViewController.dart';
import 'package:zhishu_card/Setting/SettingAboutVC.dart';
import 'package:zhishu_card/Setting/SettingSendVC.dart';
import 'package:zhishu_card/Setting/SettingViewController.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/Global.dart';
import 'package:zhishu_card/Tools/MainTool.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:zhishu_card/Tools/UserPrefereTool.dart';
import 'Home/HomeAddVC.dart';
import 'Custom/Extensions/CustomFloatingActionLocation.dart';
import 'Login/LoginViewController.dart';

main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting()
      .then((_) => Global.init().then((value) => runApp(MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenUtil.init(constraints,
            designSize: Size(375, 667), allowFontScaling: false);
        return MaterialApp(
          initialRoute: "/",
          theme: ThemeData(
              platform: TargetPlatform.iOS,
              // brightness: Brightness.light, // 主题颜色
              primaryColor: ColorUtil.styleGreen,
              appBarTheme: AppBarTheme(
                  color: ColorUtil.styleGreen, shadowColor: Colors.white),
              fontFamily: fontPingFange,
              splashColor: Colors.transparent, // 水波纹
              highlightColor: Colors.transparent),
          routes: {
            "/": (context) => UserPrefereToolLogin.isName()
                ? RootViewController()
                : LoginViewController(),
            "/root": (context) => RootViewController(),
            "/home": (context) => HomeViewController(),
            "/setting": (context) => SettingViewController(),
            "/homeAdd": (context) => HomeAddVC(),
            "/settingAbout": (context) => SettingAboutVC(),
            "/settingSend": (context) => SettingSendVC(),
            "/login": (context) => LoginViewController(),
            "/homeCalendar": (context) => HomeCalendarVC(),
          },
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
  final HomeViewController _home = HomeViewController();
  final HomeAddVC _homeAdd = HomeAddVC();
  final SettingViewController _setting = SettingViewController();
  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    Widget scaf = Scaffold(
        body: PageView(
          pageSnapping: false, // 回弹
          physics: NeverScrollableScrollPhysics(), //
          children: [_home, _homeAdd, _setting],
          controller: _pageController,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 12,
          unselectedLabelStyle: TextStyle(fontFamily: fontErasBold),
          selectedLabelStyle: TextStyle(fontFamily: fontErasBold),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "home"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "add"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "setting"),
          ],
          onTap: ((index) {
            if (index == 1) {
              return;
            }
            _pageController.jumpToPage(index);
            setState(() {
              print("index");
              _currentIndex = index;
            });
          }),
          currentIndex: _currentIndex,
        ),
        floatingActionButtonLocation:
            CustomFloatingActionButtonLocation.tabbarCenter,
        floatingActionButton: TextButton(
          onPressed: () {
            debugPrint("FloatingActionButton");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeAddVC(), fullscreenDialog: true));
          },
          child: Container(
            child: Icon(Icons.add, color: Colors.white),
            width: 80,
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24), color: Colors.blue),
          ),
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent)),
        ));
    return scaf;
  }
}
