import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileUtil {
  static String _dir;

  // 类对象初始化
  static init() async {
    _dir = (await getApplicationDocumentsDirectory()).path;
  }

  // 查询文件是否存在
  void isExistense() {}

  // 读取本地文件
  // ignore: missing_return
  static Future<File> getLocalFile(String name) async {
    final f = File("$_dir/$name");
    var r = await f.exists();
    return r == true ? f : null;
  }

  // 写入本地文件
  static Future<bool> writeAsFile(String name, List<int> bytes) async {
    final p = "$_dir/$name";
    File f = File(p);
    File r = await f.writeAsBytes(bytes);
    final b = await r.exists();
    return b;
  }

  // 删除本地文件
  static Future deleteLocalFile(String name) async {
    final p = "$_dir/$name";
    File f = File(p);
    bool isHave = await f.exists();
    if (isHave) {
      return await f.delete();
    } else {
      print("未找到文件");
      return null;
    }
  }
}
