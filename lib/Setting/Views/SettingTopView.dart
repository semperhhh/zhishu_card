import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zhishu_card/Setting/SettingAboutVC.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/FileUtil.dart';
import 'package:zhishu_card/Tools/MainTool.dart';

class SettingTopView extends StatefulWidget {
  @override
  _SettingTopViewState createState() => _SettingTopViewState();
}

class _SettingTopViewState extends State<SettingTopView> {
  MethodChannel _methodChannel = MethodChannel("picture_page");
  String _imageFile;
  File _image;
  String _nameStr = ""; // 名称
  String _descStr = ""; // 描述
  final picker = ImagePicker();

  Future getImage() async {
    final pickerdFile = await picker.getImage(source: ImageSource.gallery);
    if (pickerdFile != null) {
      print(pickerdFile.path);
      _image = File(pickerdFile.path);
      setState(() {}); // 更新状态
      // 保存图片
      _image.readAsBytes().then((list) {
        FileUtil.writeAsFile("head.png", list).then((value) {
          if (value) {
            print("头像保存成功");
          }
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // get name
    SharedPreferences.getInstance().then((value) {
      _nameStr = value.getString("name") != null ? value.getString("name") : "";
      _descStr = value.getString("desc") != null ? value.getString("desc") : "";
      setState(() {});
    });

    // get head
    FileUtil.getLocalFile("head.png").then((value) {
      if (value != null) {
        setState(() {
          _image = value;
        });
      }
    });

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
            border: Border.all(width: 4, color: ColorUtil.grey),
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
      margin: EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 180.w),
                  child: _nameStr != ""
                      ? Text(_nameStr,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontFamily: fontPingFange,
                              fontSize: 20.sp))
                      : Text("给自己起个名字吧",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp)))
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          SizedBox(height: 6),
          _descStr != ""
              ? Text(_descStr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal))
              : Text("定个小目标",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.black45, fontSize: 13.sp))
        ],
      ),
    );

    TextEditingController _nameController = TextEditingController();
    TextEditingController _descController = TextEditingController();

    Widget nameGesture = GestureDetector(
      child: nameView,
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext currentText) {
              return AlertDialog(
                title: Text("信息"),
                content: SingleChildScrollView(
                    child: ListBody(children: [
                  TextField(
                      controller: _nameController,
                      maxLength: 10,
                      decoration: InputDecoration(
                          labelText: "昵称", hintText: "不超过10个字符")),
                  TextField(
                      controller: _descController,
                      maxLength: 20,
                      decoration: InputDecoration(
                          labelText: "小目标", hintText: "不超过20个字符")),
                ])),
                actions: [
                  FlatButton(
                      child: Text("确定"),
                      onPressed: () {
                        // 昵称
                        if (_nameController.text.length > 0) {
                          _nameStr = _nameController.text;
                          SharedPreferences.getInstance().then((value) {
                            value.setString("name", _nameStr);
                          });
                        }
                        // 描述
                        if (_descController.text.length > 0) {
                          _descStr = _descController.text;
                          SharedPreferences.getInstance().then((value) {
                            value.setString("desc", _descStr);
                          });
                        }
                        Navigator.of(currentText).pop();
                        // 更新topview
                        setState(() {});
                      }),
                  FlatButton(
                      child: Text("取消"),
                      onPressed: () {
                        Navigator.of(currentText).pop();
                      })
                ],
              );
            });
      },
    );

    Widget content = Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.only(top: 20, left: 15, right: 15),
        height: 140,
        padding: EdgeInsets.only(left: 20),
        child: Row(
          children: [headView, Expanded(child: nameGesture)],
        ));
    return content;
  }

  // 父类widget值(InheritedWidget)改变时调用
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}
