class HomeModel {
  // 标题
  String name;
  // 时间(分钟)
  int time;
  // 是否完成
  bool isDone;
  // 描述
  String descriptionString;

  HomeModel(this.name, this.time,
      {this.isDone = false, this.descriptionString = ""});
}
