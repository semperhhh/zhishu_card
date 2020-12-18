import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingTopView extends StatefulWidget {
  @override
  _SettingTopViewState createState() => _SettingTopViewState();
}

class _SettingTopViewState extends State<SettingTopView> {
  MethodChannel _methodChannel = MethodChannel("picture_page");
  String _imageFile;
  @override
  void initState() {
    super.initState();
    _methodChannel.setMethodCallHandler((call) async {
      if (call.method == "picture-ios") {
        if (call.arguments == "error") {
          print("图片获取失败");
        } else if (call.arguments == "fileError") {
          print("图片地址获取失败");
        } else {
          print("图片地址 -- " + call.arguments);
          setState(() {
            _imageFile = call.arguments;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var headView = Container(
      height: 60,
      width: 60,
      child: GestureDetector(
        onTap: () {
          print("点击了头像 调出原生相册");
          _methodChannel.invokeMapMethod("picture");
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: _imageFile == null
                    ? AssetImage("asset/images/me_head_empty.png")
                    : FileImage(File(_imageFile))),
          ),
        ),
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
