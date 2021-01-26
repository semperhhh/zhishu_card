import 'UserPrefereTool.dart';
import 'SqliteTool.dart';

class Global {
  static Future init() async {
    await UserPrefereTool.init();
    await SqliteTool.openData();
    print("Global load success -----");
  }
}
