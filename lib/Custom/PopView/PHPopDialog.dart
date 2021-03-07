import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zhishu_card/Custom/UI/PHBaseButton.dart';
import 'package:zhishu_card/Tools/ColorUtil.dart';

// 自定义toast
void showToastDialog(
    {@required BuildContext context,
    @required String text,
    int milliseconds = 2000}) async {
  Navigator.of(context).push(
    _ZPHCustomDialogRoute(
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

// 任务描述弹窗
Future<String> showDescriptionChangeDialogView(
    {@required BuildContext context, String currentStr}) {
  return showTextFieldDialogView(
      context: context, currentStr: currentStr, hintStr: "记录下努力的过程吧");
}

// fightingString弹窗
Future<String> showFightingChangeDialogView(
    {@required BuildContext context, String currentStr}) {
  return showTextFieldDialogView(
      context: context, currentStr: currentStr, hintStr: "更新您的今日鸡汤吧!");
}

// 自定义弹窗
Future<String> showTextFieldDialogView(
    {@required BuildContext context, String currentStr, String hintStr}) async {
  TextEditingController _textcontroller =
      TextEditingController(text: currentStr);
  var result = await Navigator.of(context).push(
    _ZPHCustomDialogRoute(
      pageBuilder: (pagetext, animation, secondaryAnimation) {
        // 输入框
        TextField _textfield = TextField(
            controller: _textcontroller,
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
                hintText: hintStr,
                hintStyle: TextStyle(fontSize: 15.sp)),
            style: TextStyle(
                fontSize: 16.sp,
                color: Theme.of(context).textTheme.bodyText2.color),
            maxLines: null);

        // 输入View
        Widget contentView = Container(
            constraints: BoxConstraints(minHeight: 80, maxHeight: 280),
            decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.circular(4)),
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
                child: PHBaseButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: ColorUtil.grey,
                  child: Text(
                    "稍后",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
              ),
              Expanded(
                child: PHBaseButton(
                  child: Text(
                    "确定",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  onPressed: () {
                    print("textcontroller - ${_textcontroller.text}");
                    Navigator.of(context).pop("navigator pop");
                  },
                  color: ColorUtil.blue,
                ),
              ),
            ],
          ),
        );

        return UnconstrainedBox(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Material(
                  color: Theme.of(context).backgroundColor,
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
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: Curves.easeOutBack),
          child: child,
        );
      },
    ),
  );

  print("result - $result");
  return _textcontroller.text;
}

class _ZPHCustomDialogRoute extends PopupRoute {
  _ZPHCustomDialogRoute(
      {@required RoutePageBuilder pageBuilder,
      bool barrierDismissible = true,
      Color barrierColor = Colors.red,
      String barrierLabel,
      Duration transitionDuration = const Duration(seconds: 2),
      RouteTransitionsBuilder transitionBuilder,
      RouteSettings settings})
      : _pageBuilder = pageBuilder,
        _barrierDismissible = barrierDismissible,
        _barrierColor = barrierColor,
        _barrierLabel = barrierLabel,
        _transitionBuilder = transitionBuilder,
        _transitionDuration = transitionDuration,
        super(settings: settings);

  final RoutePageBuilder _pageBuilder;

  // 动画
  final RouteTransitionsBuilder _transitionBuilder;

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

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (_transitionBuilder == null) {
      return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.linear,
          ),
          child: child);
    } // Some default transition
    return _transitionBuilder(context, animation, secondaryAnimation, child);
  }
}
