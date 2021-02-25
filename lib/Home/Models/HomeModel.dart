import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:json_annotation/json_annotation.dart';

// user.g.dart 将在我们运行生成命令后自动生成
part 'HomeModel.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class HomeModel {
  // 任务id
  int taskId;
  // 标题
  String name;
  // 时间(分钟)
  int time;
  // 是否完成
  bool isDone;
  // 描述
  String descriptionString;

  HomeModel(this.taskId, this.name, this.time,
      {this.isDone = false, this.descriptionString = ""});

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);
  Map<String, dynamic> toJson() => _$HomeModelToJson(this);

  // HomeModel.fromJSON(Map<String, dynamic> json)
  //     : name = json["name"],
  //       time = json["time"],
  //       isDone = json["isDone"],
  //       descriptionString = json["descriptionString"];

  // Map<String, dynamic> toMap() => <String, dynamic>{
  //       "name": name,
  //       "time": time,
  //       "isDone": isDone,
  //       "descriptionString": descriptionString
  //     };
}
