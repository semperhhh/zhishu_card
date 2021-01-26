import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhishu_card/Custom/PopView/ZPHPopDialog.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';
import 'package:zhishu_card/Tools/MainTool.dart';
import 'package:zhishu_card/Tools/UserPrefereTool.dart';
import '../../Tools/ColorUtil.dart';
import '../Models/HomeModel.dart';

typedef CellDidSelectCallback = void Function();

// cell
class HomeTableViewCell extends StatefulWidget {
  // 名称
  final String name;
  // 数据
  HomeModel model;
  // 点击cell时的回调
  CellDidSelectCallback didSetCallback;
  // init
  HomeTableViewCell({
    Key key,
    this.name,
    this.didSetCallback,
    @required this.model,
  }) : super(key: key);
  @override
  _HomeTableViewCellState createState() => _HomeTableViewCellState();
}

class _HomeTableViewCellState extends State<HomeTableViewCell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int timeInt = widget.model.time;

    // 背景样式
    CellColor _cellcolor = CellColor.random(timeInt);

    // 标题
    Text nameText = Text(widget.model.name,
        style: TextStyle(
            fontSize: 16.w, color: Colors.white, fontWeight: fontMedium));

    // 时间内容
    final int hourInt = timeInt ~/ 60;
    final int minuteInt = timeInt % 60;

    // 时
    TextSpan hourTextSpan = TextSpan(
      children: [
        TextSpan(
            text: hourInt.toString(),
            style: TextStyle(
                fontSize: 24.w, fontWeight: fontMedium, color: Colors.white)),
        TextSpan(
            text: "时",
            style: TextStyle(
                fontSize: 15.w,
                fontWeight: FontWeight.bold,
                color: _cellcolor.timeColor)),
      ],
    );

    // 分
    TextSpan minuteTextSpan = TextSpan(children: [
      TextSpan(
          text: minuteInt.toString(),
          style: TextStyle(
              fontSize: 24.w, fontWeight: fontMedium, color: Colors.white)),
      TextSpan(
          text: "分",
          style: TextStyle(
              fontSize: 15.w,
              fontWeight: FontWeight.bold,
              color: _cellcolor.timeColor))
    ]);

    // 时间
    Text subNameText = Text.rich(
      TextSpan(
          children:
              hourInt > 0 ? [hourTextSpan, minuteTextSpan] : [minuteTextSpan]),
    );

    // 打卡按钮
    TextButton clockButton = TextButton(
      onPressed: () {
        print("click button");
        widget.model.isDone = true;
        setState(() {});
        widget.didSetCallback();
        // 回调
      },
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        alignment: Alignment.center,
        height: 36,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36), color: Colors.white),
        child: Text(
          "打卡",
          style: TextStyle(
              color: _cellcolor.bgColor,
              fontWeight: fontMedium,
              fontSize: 14.w),
        ),
      ),
    );

    // 完成
    Widget doneView = Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        alignment: Alignment.center,
        child: Text("Done!",
            style: TextStyle(
                color: Colors.black,
                fontWeight: fontMedium,
                fontSize: 16.sp,
                fontFamily: fontErasBold)));

    Widget stackView = Container(
      height: 88,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nameText,
                SizedBox(height: 6),
                subNameText,
              ],
            ),
          ),
          Positioned(
            top: -10,
            right: -20,
            width: 70,
            height: 70,
            child: Image.asset("asset/images/${_cellcolor.imageName}.png"),
          ),
          Positioned(
            right: 15,
            child: widget.model.isDone == true ? doneView : clockButton,
          )
        ],
      ),
    );

    // 描述
    Widget descView = Container(
      child: Stack(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(height: 0.5, color: ColorUtil.grey)),
          Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                widget.model.descriptionString,
                style: TextStyle(fontSize: 13.sp),
              ))
        ],
      ),
    );

    Widget contentView = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.model.descriptionString != ""
          ? [stackView, descView]
          : [stackView],
    );

    Widget _container = Container(
      margin: EdgeInsets.only(top: 6, bottom: 6),
      child: ClipRRect(
        child: Container(
          child: contentView,
          color: _cellcolor.bgColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    Widget _gesture = GestureDetector(
        child: _container,
        onLongPress: () {
          print("长按添加记录");
          showTextFieldDialogView(
                  context: context, currentStr: widget.model.descriptionString)
              .then((value) {
            print("showTextFieldDialogView - $value");
            setState(() {
              widget.model.descriptionString = value;
            });
          });
          // showToastDialog(
          // context: context, milliseconds: 2000, text: "点击了弹窗!!!");
        });
    return _gesture;
  }
}
