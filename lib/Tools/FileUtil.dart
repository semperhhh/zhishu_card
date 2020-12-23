import 'dart:io';
import 'package:path_provider/path_provider.dart';

// 读取本地文件
Future<File> getLocalFile() async {
  String dir = (await getApplicationDocumentsDirectory()).path;
  return File("$dir/head.png");
}

// 写入本地文件
Future<Null> writeAsFile() async {
  await (await getLocalFile()).writeAsBytes([123]);
}
