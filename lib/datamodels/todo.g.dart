// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map json) => Todo(
      json['category'] as String,
      json['title'] as String,
      json['description'] as String,
      json['completedStatus'] as bool,
      json['type'] as String,
      const TimestampConverter().fromJson(json['createdAt']),
      const TimestampConverter().fromJson(json['updatedAt']),
      json['userId'] as String,
      json['todoId'] as String,
    );

Map<String, dynamic> _$TodoToJson(Todo instance) {
  final val = <String, dynamic>{
    'category': instance.category,
    'title': instance.title,
    'description': instance.description,
    'completedStatus': instance.completedStatus,
    'type': instance.type,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'createdAt', const TimestampConverter().toJson(instance.createdAt));
  writeNotNull(
      'updatedAt', const TimestampConverter().toJson(instance.updatedAt));
  val['userId'] = instance.userId;
  val['todoId'] = instance.todoId;
  return val;
}
