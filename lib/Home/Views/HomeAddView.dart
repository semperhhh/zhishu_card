import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhishu_card/Tools/MainTool.dart';

class HomeAddView extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  FocusNode _nameFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _titleWidget(),
        _nameWidget(),
        _timeWidget(),
        SizedBox(height: 44),
        _addButtonWidget()
      ],
    );
  }

  Widget _titleWidget() {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      width: ScreenUtil().screenWidth,
      child: Text(
        "新建任务",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22.sp, fontFamily: fontKuaile),
      ),
    );
  }

  Widget _nameWidget() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 44),
      child: TextField(
        controller: _nameController,
        focusNode: _nameFocus,
        decoration: InputDecoration(labelText: "任务名称"),
      ),
    );
  }

  Widget _timeWidget() {
    return GestureDetector(
      onTap: () {
        print("时间选择");
      },
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
    );
  }

  Widget _addButtonWidget() {
    return CupertinoButton(
      color: Colors.red,
      child: Text("添加"),
      onPressed: () {
        print("添加任务");
      },
    );
  }
}
