import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhishu_card_flutter/Tools/ColorUtil.dart';
import 'package:zhishu_card_flutter/Tools/MainTool.dart';

// 自定义toast
void showToastDialog(
    {@required BuildContext context,
    @required String text,
    int milliseconds = 2000}) async {
  Navigator.of(context).push(
    _PHCustomDialogRoute(
      pageBuilder: (context, animation, secondaryAnimation) {
        return UnconstrainedBox(
            alignment: Alignment(0, 0.7),
            child: Material(
                type: MaterialType.card,
                color: Colors.transparent,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 300.w),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 8, bottom: 8),
                      child: Text(text, style: TextStyle(color: Colors.white))),
                )));
      },
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 100),
    ),
  );

  Future.delayed(Duration(milliseconds: milliseconds)).then((value) {
    Navigator.of(context).pop();
  });
}

// 自定义弹窗
Future<String> showTextFieldDialogView(
    {@required BuildContext context, String currentStr}) async {
  TextEditingController _textcontroller =
      TextEditingController(text: currentStr);
  var result = await Navigator.of(context).push(
    _PHCustomDialogRoute(
      pageBuilder: (pagetext, animation, secondaryAnimation) {
        // 输入框
        TextField _textfield = TextField(
            controller: _textcontroller,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                hintText: "记录下努力的过程吧~",
                hintStyle: TextStyle(fontSize: 15.sp, fontFamily: fontKuaile)),
            style: TextStyle(fontFamily: fontKuaile, fontSize: 16.sp),
            maxLines: null);

        // 输入View
        Widget contentView = Container(
            constraints: BoxConstraints(minHeight: 80, maxHeight: 280),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4)),
            width: 280,
            child: _textfield);

        // 按钮
        Widget buttonView = ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 280, maxHeight: 44),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: ColorUtil.grey,
                      child: Text("稍后",
                          style: TextStyle(
                              fontFamily: fontKuaile,
                              fontSize: 16,
                              color: Colors.black54)))),
              Expanded(
                  child: FlatButton(
                      onPressed: () {
                        print("textcontroller - ${_textcontroller.text}");
                        Navigator.of(context).pop("navigator pop");
                      },
                      color: ColorUtil.blue,
                      child: Text("确定",
                          style: TextStyle(
                              fontFamily: fontKuaile,
                              fontSize: 16,
                              color: Colors.black87)))),
            ],
          ),
        );

        return UnconstrainedBox(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Material(
                  color: Colors.white,
                  child: Column(
                    children: [
                      contentView,
                      SizedBox(height: 8),
                      buttonView,
                    ],
                  ),
                )));
      },
      barrierColor: Colors.black54,
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 300),
    ),
  );

  print("result - $result");
  return _textcontroller.text;
}

class _PHCustomDialogRoute extends PopupRoute {
  _PHCustomDialogRoute(
      {@required RoutePageBuilder pageBuilder,
      bool barrierDismissible = true,
      Color barrierColor = Colors.red,
      String barrierLabel,
      Duration transitionDuration = const Duration(seconds: 2),
      RouteSettings settings})
      : _pageBuilder = pageBuilder,
        _barrierDismissible = barrierDismissible,
        _barrierColor = barrierColor,
        _barrierLabel = barrierLabel,
        _transitionDuration = transitionDuration,
        super(settings: settings);

  final RoutePageBuilder _pageBuilder;

  @override
  Color get barrierColor => _barrierColor;
  final Color _barrierColor;

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  String get barrierLabel => _barrierLabel;
  final String _barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Semantics(
      child: _pageBuilder(context, animation, secondaryAnimation),
      scopesRoute: true,
      explicitChildNodes: true,
    );
  }

  @override
  Duration get transitionDuration => _transitionDuration;
  final Duration _transitionDuration;
}