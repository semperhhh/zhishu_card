import 'package:flutter/material.dart';

class HomeAddVC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTapDown: (details) {
              Navigator.pop(context);
            },
            child: Visibility(
              maintainAnimation: true,
              maintainState: true,
              visible: true,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color:
                        // Theme.of(context).bottomSheetTheme.modalBackgroundColor,
                        Colors.red),
              ),
            ),
          ),
          Positioned(
            top: 100.0,
            left: 50.0,
            child: Visibility(
              visible: true,
              child: Text("添加任务"),
            ),
          ),
        ],
      ),
    );
  }
}
