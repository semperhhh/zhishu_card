import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../SettingViewController.dart';

class SettingTopView extends StatefulWidget {
  @override
  _SettingTopViewState createState() => _SettingTopViewState();
}

class _SettingTopViewState extends State<SettingTopView> {
  @override
  Widget build(BuildContext context) {
    var headView = Container(
      height: 60,
      width: 60,
      child: Image.asset(
        "asset/images/my_微信_icon.png",
        height: 56,
        width: 56,
      ),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.cyan,
            width: 4,
          )),
    );
    var nameView = Container(
        margin: EdgeInsets.only(left: 8),
        height: 56,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "name",
              style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            SizedBox(height: 6),
            Text("描述 描述 描述 ", textAlign: TextAlign.left),
          ],
        ));
    Widget content = Container(
      color: Colors.yellow,
      height: 140,
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.only(left: 20),
      child: Row(
        children: [headView, nameView],
      ),
    );
    return content;
  }

  // 父类widget值(InheritedWidget)改变时调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
