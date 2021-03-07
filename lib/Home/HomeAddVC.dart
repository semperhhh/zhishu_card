import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhishu_card/Custom/PopView/PHPopDialog.dart';
import 'package:zhishu_card/Home/Models/HomeModel.dart';
import 'package:zhishu_card/Home/Util/HomeModelUtil.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/UserPrefereTool.dart';

class HomeAddVC extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  FocusNode _nameFocus = FocusNode();
  TextEditingController _timeController = TextEditingController();
  FocusNode _timeFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新建任务", style: Theme.of(context).textTheme.headline6),
      ),
      body: GestureDetector(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _nameWidget(),
              SizedBox(height: 24.h),
              _timeWidget(context),
              SizedBox(height: 150.h),
              _addButtonWidget(context)
            ],
          ),
        ),
        onTap: () {
          if (_nameFocus.hasFocus) {
            _nameFocus.unfocus();
          }
          if (_timeFocus.hasFocus) {
            _timeFocus.unfocus();
          }
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

  Widget _timeWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 24),
      child: TextField(
        controller: _timeController,
        focusNode: _timeFocus,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "任务时间",
          labelStyle: TextStyle(color: Colors.grey),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ),
      ),
    );
  }

  Widget _addButtonWidget(BuildContext context) {
    return CupertinoButton(
      color: ColorUtil.blue,
      child: Text(
        "添加",
        style: TextStyle(fontSize: 16),
      ),
      onPressed: () {
        String name = _nameController.text;
        String time = _timeController.text;
        print("添加任务 name - $name -- time - $time");
        if (name.isEmpty || time.isEmpty) {
          showToastDialog(context: context, text: "名称与时间不能为空");
        } else {
          HomeModel m =
              HomeModel(UserPrefereTool.sharedTaskId(), name, int.parse(time));
          HomeModelUtil.shared.allTaskList.add(m); // 添加全部任务
          HomeModelUtil.shared.currentTaskList.add(m); // 添加今日任务
          Navigator.pop(context);
        }
      },
    );
  }
}
