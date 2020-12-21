import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class SettingTopView extends StatefulWidget {
  @override
  _SettingTopViewState createState() => _SettingTopViewState();
}

class _SettingTopViewState extends State<SettingTopView> {
  MethodChannel _methodChannel = MethodChannel("picture_page");
  String _imageFile;
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickerdFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickerdFile != null) {
        print(pickerdFile.path);
        _image = File(pickerdFile.path);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    /* 调用原生相册
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
    */
  }

  @override
  Widget build(BuildContext context) {
    var headView = Container(
      height: 60,
      width: 60,
      child: GestureDetector(
        onTap: () {
          print("GestureDetector");
          getImage();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            border: Border.all(width: 4, color: Colors.cyan),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: _image == null
                    ? AssetImage("asset/images/me_head_empty.png")
                    : FileImage(_image)),
          ),
        ),
      ),
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
