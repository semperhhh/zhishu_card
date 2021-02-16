import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zhishu_card/Custom/PopView/ZPHPopDialog.dart';
import 'package:zhishu_card/Tools/MainTool.dart';
import 'package:zhishu_card/Tools/UserPrefereTool.dart';
import 'package:zhishu_card/main.dart';

// 登录界面

class LoginViewController extends StatefulWidget {
  @override
  _LoginViewControllerState createState() => _LoginViewControllerState();
}

class _LoginViewControllerState extends State<LoginViewController> {
  TextEditingController _nickNameController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_focusNode.hasFocus) {
        print(_scrollController.offset);
        _focusNode.unfocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              print("GestureDetector.ontap");
              _focusNode.unfocus();
            },
            child: Container(
                width: ScreenUtil().screenWidth,
                child: ListView(
                  children: [
                    SizedBox(height: 100),
                    _textTopWidget(),
                    SizedBox(height: 80),
                    Padding(
                        padding: EdgeInsets.only(left: 50.0, right: 50.0),
                        child: _textFieldFromNickName()),
                    SizedBox(height: 240),
                    _textButtonFromLogin(context),
                  ],
                  controller: _scrollController,
                ))));
  }

  Widget _textTopWidget() {
    return Text("Join us",
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.blue[300],
            fontSize: 40,
            fontWeight: FontWeight.w600,
            fontFamily: fontErasBold,
            decoration: TextDecoration.underline,
            decorationColor: Colors.blue[200],
            decorationStyle: TextDecorationStyle.dashed));
  }

  TextField _textFieldFromNickName() {
    return TextField(
        controller: _nickNameController,
        maxLength: 8,
        maxLines: 1,
        focusNode: _focusNode,
        decoration: InputDecoration(
            labelText: "昵称",
            labelStyle: TextStyle(color: Colors.blue),
            hintText: "请输入昵称",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
            counterText: ""));
  }

  TextButton _textButtonFromLogin(BuildContext loginContext) {
    return TextButton(
        onPressed: () {
          final nickName = _nickNameController.text;
          print(nickName);
          if (nickName == null || nickName.length < 1) {
            showToastDialog(context: loginContext, text: "请输入至少一个字符的昵称");
            return;
          }
          UserPrefereToolLogin.login(nickName);
          Navigator.pushReplacement(
            loginContext,
            MaterialPageRoute(
              builder: (context) => RootViewController(),
              maintainState: false,
              fullscreenDialog: true,
            ),
          );
        },
        child: Container(
            width: 120.0,
            height: 40.0,
            decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: BorderRadius.circular(18.0)),
            child: Text("开始",
                style: TextStyle(color: Colors.white, fontSize: 16.sp)),
            alignment: Alignment.center),
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(Colors.transparent)));
  }
}
