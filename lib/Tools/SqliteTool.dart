import 'package:sqflite/sqflite.dart';

class SqliteTool {
  // 数据库
  static Database db;

  static Future openData() async {
    var databasesPath = await getDatabasesPath();
    print("databasespath = $databasesPath");
    var path = "$databasesPath/zhishu.db";

    await deleteDatabase(path);

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        print("oncreate ---没有数据库就创建---- ");
        db.execute("""
        create table allTask (
	        content text,
	        isFinish int default 0,
	        allTime int default 0,
	        time int default 0
        )
        """);
        db.execute("""
        create table taskSeries (
	        taskId int not null,
	        days int default 0
        )
        """);
      },
    );
  }

  // 增-每天任务
  static Future<bool> insertFromYesterday(String yesterday) {
    print("yesterDay -- $yesterday");
  }

  // 增
  static Future<bool> insert() {
    return db.insert("home", {}).then((i) {
      print(i);
      if (i != null) {
        return true;
      } else {
        return false;
      }
    });
  }

  // 查
  static Future<List> getMap() {
    return db.query("home").then((value) {
      return value;
    });
  }

  // 删
  static Future<int> delete(int id) {
    return db.delete("home", where: "id = ?'", whereArgs: [id]).then((value) {
      return value;
    });
  }
  // 改
}
