import 'package:zhishu_card/Home/Util/HomeModelUtil.dart';
import 'package:zhishu_card/Tools/FileUtil.dart';

import 'UserPrefereTool.dart';
import 'SqliteTool.dart';

class Global {
  static Future init() async {
    await UserPrefereTool.init();
    await SqliteTool.openData();
    await FileUtil.init();
    await HomeModelUtil.init();
    print("Global load success -----");
  }
}
