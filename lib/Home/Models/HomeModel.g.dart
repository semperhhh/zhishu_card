// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) {
  return HomeModel(
    json['taskId'] as int,
    json['name'] as String,
    json['time'] as int,
    isDone: json['isDone'] as bool,
    descriptionString: json['descriptionString'] as String,
  );
}

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'taskId': instance.taskId,
      'name': instance.name,
      'time': instance.time,
      'isDone': instance.isDone,
      'descriptionString': instance.descriptionString,
    };
