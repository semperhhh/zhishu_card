import 'package:flutter/material.dart';

class PHBaseButton extends MaterialButton {
  const PHBaseButton({
    Color color,
    Widget child,
    void Function() onLongPress,
    void Function() onPressed,
  }) : super(
          child: child,
          color: color,
          onLongPress: onLongPress,
          onPressed: onPressed,
        );

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      child: child,
      shape: Border.all(color: color),
    );
  }
}
