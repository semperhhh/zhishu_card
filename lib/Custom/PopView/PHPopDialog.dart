import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
Future showCustomDialogView(
    {@required BuildContext context, @required RoutePageBuilder pageBuilder}) {
  return Navigator.of(context)
      .push(_PHCustomDialogRoute(pageBuilder: pageBuilder));
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
