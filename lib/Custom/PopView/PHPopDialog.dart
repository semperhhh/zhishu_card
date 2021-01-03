import 'package:flutter/material.dart';
import 'package:zhishu_card_flutter/Tools/ColorUtil.dart';

// 自定义toast
Future showToastDialog(
    {@required BuildContext context, @required Widget child}) {
  return Navigator.of(context).push(
    _PHCustomDialogRoute(
      pageBuilder: (context, animation, secondaryAnimation) {
        return UnconstrainedBox(
            child: Material(
                color: Colors.transparent,
                type: MaterialType.card,
                child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 280),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        padding: EdgeInsets.all(15),
                        child: child))));
      },
      barrierColor: Colors.black87,
      barrierDismissible: true,
      transitionDuration: Duration(milliseconds: 200),
    ),
  );
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
