import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/MainTool.dart';

class HomeAddVC extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  FocusNode _nameFocus = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新建任务"),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
      ),
      body: GestureDetector(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _nameWidget(),
              SizedBox(height: 24),
              _timeWidget(),
              SizedBox(height: 120),
              _addButtonWidget()
            ],
          ),
        ),
        onTap: () {
          _nameFocus.unfocus();
        },
      ),
    );
  }

  Widget _nameWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 44),
      child: TextField(
        controller: _nameController,
        focusNode: _nameFocus,
        decoration: InputDecoration(
          labelText: "任务名称",
          labelStyle: TextStyle(color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
      ),
    );
  }

  Widget _timeWidget() {
    return Listener(
      child: Padding(
        padding: EdgeInsets.only(top: 20.0, left: 12.0, right: 12.0),
        child: Container(
          color: Colors.red,
          padding: EdgeInsets.only(top: 12.0, bottom: 12.0),
          width: ScreenUtil().screenWidth,
          child: Text(
            "添加预计时长",
            // textAlign: TextAlign.start,
            style: TextStyle(fontSize: 16.0, color: Colors.black54),
          ),
        ),
      ),
      onPointerDown: (event) {
        print("添加时间");
      },
    );
  }

  Widget _addButtonWidget() {
    return CupertinoButton(
      color: ColorUtil.blue,
      child: Text("添加"),
      onPressed: () {
        print("添加任务 name - ${_nameController.text}");
      },
    );
  }
}
