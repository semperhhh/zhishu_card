import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileUtil {
  // 查询文件是否存在
  void isExistense() {}

  // 读取本地文件
  // ignore: missing_return
  static Future<File> getLocalFile(String name) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    final f = File("$dir/$name");
    var r = await f.exists();
    return r == true ? f : null;
  }

  // 写入本地文件
  static Future<bool> writeAsFile(String name, List<int> bytes) async {
    final dir = (await getApplicationDocumentsDirectory()).path;
    final p = "$dir/$name";
    File f = File(p);
    File r = await f.writeAsBytes(bytes);
    final b = await r.exists();
    return b;
  }
}
