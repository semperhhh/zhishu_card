import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'Tools/ThemeModel.dart';

main(List<String> args) {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark); // 导航栏
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
      (value) => initializeDateFormatting()
          .then((_) => Global.init().then((value) => runApp(MyApp()))));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        ScreenUtil.init(constraints,
            designSize: Size(375, 667), allowFontScaling: true);
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: ThemeModel()),
            ChangeNotifierProvider.value(value: UserModel()),
          ],
          child: Consumer<ThemeModel>(
            builder: (_, thememodel, __) {
              return GetMaterialApp(
                initialRoute: "/",
                theme: ThemeModel.getTheme(),
                darkTheme: ThemeModel.getTheme(isDarkMode: true),
                themeMode: thememodel.themeMode,
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
          backgroundColor: ThemeModel.isDarkMode(context)
              ? ColorUtil.main_dark1_app
              : Colors.white,
          unselectedLabelStyle: TextStyle(
              fontFamily: fontErasBold,
              fontWeight: FontWeight.w500,
              fontSize: 11),
          selectedLabelStyle: TextStyle(
              fontFamily: fontErasBold,
              fontWeight: FontWeight.w500,
              fontSize: 11),
          selectedIconTheme: IconThemeData(color: ColorUtil.fromHex("#5B7CFF")),
          selectedItemColor: ColorUtil.fromHex("#5B7CFF"),
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("asset/images/homepage_copy.png")),
                label: "首页"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "add"),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage("asset/images/setting_copy.png")),
                label: "设置"),
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
            child: Image.asset("asset/images/tabbar_add.png"),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22), color: Colors.white),
          ),
          style: ButtonStyle(
              overlayColor: MaterialStateProperty.all(Colors.transparent)),
        ));
    return scaf;
  }
}
