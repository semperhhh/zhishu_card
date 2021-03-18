import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/FileUtil.dart';
import 'package:zhishu_card/Tools/MainTool.dart';
import 'package:zhishu_card/Tools/ThemeModel.dart';
import 'package:zhishu_card/Tools/UserPrefereTool.dart';

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
    print("设置获取名字 -- ");
    _nameStr = UserPrefereTool.name ?? "";
    _descStr = UserPrefereTool.desc ?? "";
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
      height: 72,
      width: 72,
      child: GestureDetector(
        onTap: () {
          print("GestureDetector");
          getImage();
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(36)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: _image == null
                    ? AssetImage("asset/images/setting_head_empty.png")
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
                              color: ThemeModel.isDarkMode(context)
                                  ? ColorUtil.main_light_app
                                  : Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontFamily: fontPingFange,
                              fontSize: 26.sp))
                      : Text("名字",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: ThemeModel.isDarkMode(context)
                                  ? ColorUtil.main_light_app
                                  : ColorUtil.fromHex("#222222"),
                              fontWeight: FontWeight.w600,
                              fontSize: 26.sp)))
            ],
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          SizedBox(height: 6),
          _descStr != ""
              ? Text(_descStr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: ThemeModel.isDarkMode(context)
                          ? ColorUtil.main_light_app
                          : Colors.black45,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal))
              : Text("冲鸭!越努力越幸运",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: ThemeModel.isDarkMode(context)
                          ? ColorUtil.main_light_app
                          : ColorUtil.fromHex("#ABABAB"),
                      fontSize: 14.sp))
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
              UserModel user = Provider.of<UserModel>(currentText);
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
                  TextButton(
                      child: Text("确定"),
                      onPressed: () {
                        // 昵称
                        if (_nameController.text.length > 0) {
                          _nameStr = _nameController.text;
                          user.name = _nameController.text;
                        }
                        // 描述
                        if (_descController.text.length > 0) {
                          _descStr = _descController.text;
                          user.desc = _descController.text;
                        }
                        Navigator.of(currentText).pop();
                        // 更新topview
                        setState(() {});
                      }),
                  TextButton(
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
          color: ThemeModel.isDarkMode(context)
              ? ColorUtil.main_dark1_app
              : ColorUtil.fromHex("#FBFBFF"),
        ),
        height: 175.sp + ScreenUtil().statusBarHeight,
        padding: EdgeInsets.only(
            left: 20, right: 20, top: ScreenUtil().statusBarHeight),
        child: Row(
          children: [Expanded(child: nameGesture), headView],
        ));
    return content;
  }
}
