import 'package:sqflite/sqflite.dart';

class SqliteTool {
  // 数据库
  static Database _db;

  static Future openData() async {
    if (_db != null) {
      return;
    }
    var databasesPath = await getDatabasesPath();
    print("databasespath = $databasesPath");
    var path = "$databasesPath/zhishu.db";

    // await deleteDatabase(path);

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        print("oncreate ---没有数据库就创建---- ");
        db.execute("""
        create table allTask (
	        content text,
	        isFinish int default 0,
	        allTime int default 0,
          doneTime int default 0,
	        todayTime int default 0
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
    print("数据库 load success ---- ");
  }

  // 增
  static Future<bool> insert() {
    return _db.insert("home", {}).then((i) {
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
    return _db.query("allTask").then((value) {
      return value;
    });
  }

  // 删
  static Future<int> delete(int id) {
    return _db.delete("home", where: "id = ?'", whereArgs: [id]).then((value) {
      return value;
    });
  }
  // 改
}

extension SqliteToolTask on SqliteTool {
  // 增-每天任务
  static void insertFromYesterday(List l, String saveDay) {
    Map<String, dynamic> m = SqliteToolTask._parseMapFromYesterday(l, saveDay);
    if (m is Map<String, dynamic>) {
      SqliteTool._db.insert("allTask", m).then((i) {
        print("保存数据库 昨天的内容----------- $i");
      });
    }
  }

  // 处理昨天任务的保存数据库
  static Map<String, dynamic> _parseMapFromYesterday(
      List list, String saveDay) {
    print("处理昨天任务的保存数据库");
    Map m = Map<String, dynamic>();
    int index = 0;
    int isFinish = 0;
    int doneTime = 0;
    int allTime = 0;
    list.forEach((element) {
      if (element is Map) {
        if (element["isDone"] == true) {
          // 是否完成
          isFinish += 1;
          doneTime += element["time"];
        }
        if (element["time"] != null) {
          // 完成的时间(分钟)
          allTime += element["time"];
        }
      }
      index += 1;
    });
    if (isFinish == index) {
      m["isFinish"] = 2;
    } else if (isFinish == 0) {
      m["isFinish"] = 0;
    } else {
      m["isFinish"] = 1;
    }
    m["doneTime"] = doneTime;
    m["allTime"] = allTime;
    m["todayTime"] = saveDay;
    m["content"] = list.toString();
    return m;
  }
}
