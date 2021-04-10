import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zhishu_card/Custom/PopView/PHPopDialog.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/ThemeModel.dart';
import 'package:zhishu_card/Tools/UserPrefereTool.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: 180),
          child: Container(
            width: 375.sw,
            child: Stack(
              children: [
                Positioned(
                  child: Image.asset("asset/images/home_background.png"),
                  right: 0,
                  bottom: 0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Text("任务",
                            style: TextStyle(
                                color: ThemeModel.isDarkMode(context)
                                    ? ColorUtil.main_light_app
                                    : ColorUtil.fromHex("#222222"),
                                fontWeight: FontWeight.w600,
                                fontSize: 26.sp)),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onLongPress: () {
                          print("长按");
                          showFightingChangeDialogView(
                                  context: context, currentStr: user.fighting)
                              .then((value) {
                            user.fighting = value;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 8, right: 115),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(minHeight: 66),
                            child: Text(
                              user.fighting,
                              style: TextStyle(
                                  fontSize: 15.sp, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class HomeEmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "当前无任务",
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
