import 'dart:convert';

// JSON工具类
class JSONTool {
  // 转json字符串
  static String toJSONString<T>(T object) {
    return jsonEncode(object);
  }

  // json转class(list map)
  static dynamic toClass(String string) {
    return jsonDecode(string);
  }
}
