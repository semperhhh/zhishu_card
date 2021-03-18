import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhishu_card/Custom/PopView/PHPopDialog.dart';
import 'package:zhishu_card/Home/Models/HomeModel.dart';
import 'package:zhishu_card/Home/Util/HomeModelUtil.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/ThemeModel.dart';
import 'package:zhishu_card/Tools/UserPrefereTool.dart';

class HomeAddVC extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  FocusNode _nameFocus = FocusNode();
  TextEditingController _timeController = TextEditingController();
  FocusNode _timeFocus = FocusNode();

  Color _labelColor = ColorUtil.fromHex("#808080");
  Color _fillColor = ColorUtil.fromHex("#F8F8F8");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新建任务", style: Theme.of(context).textTheme.headline6),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: GestureDetector(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _nameWidget(context),
              SizedBox(height: 20.h),
              _timeWidget(context),
              SizedBox(height: 120.h),
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

  Widget _nameWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 44),
      child: TextField(
        controller: _nameController,
        focusNode: _nameFocus,
        style: TextStyle(fontSize: 16.sp),
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: ThemeModel.isDarkMode(context)
              ? ColorUtil.main_dark2_app
              : _fillColor,
          filled: true,
          labelText: "点击编辑任务名称",
          labelStyle: TextStyle(color: _labelColor),
        ),
      ),
    );
  }

  Widget _timeWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 24),
      child: TextField(
        controller: _timeController,
        focusNode: _timeFocus,
        style: TextStyle(fontSize: 16.sp),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: ThemeModel.isDarkMode(context)
              ? ColorUtil.main_dark2_app
              : _fillColor,
          filled: true,
          labelText: "任务时间(分钟)",
          labelStyle: TextStyle(color: _labelColor),
        ),
      ),
    );
  }

  Widget _addButtonWidget(BuildContext context) {
    return CupertinoButton(
      color: ColorUtil.fromHex("#5B7CFF"),
      child: Text(
        "新建",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
      padding: EdgeInsets.only(left: 90, right: 90),
      borderRadius: BorderRadius.circular(24),
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
