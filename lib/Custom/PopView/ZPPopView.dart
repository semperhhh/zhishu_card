import 'package:flutter/material.dart';
import 'package:zhishu_card_flutter/Tools/ColorUtil.dart';

class ZPPopView extends Dialog {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Container(
      child: Text("123"),
      color: ColorUtil.random(),
    ));
  }
}
