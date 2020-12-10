import 'package:flutter/material.dart';

main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RootViewController(),
      theme: ThemeData(
        primaryColor: Colors.cyan,
      ),
    );
  }
}

class RootViewController extends StatefulWidget {
  @override
  _RootViewControllerState createState() => _RootViewControllerState();
}

class _RootViewControllerState extends State<RootViewController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      body: Text("123"),
    );
  }
}
