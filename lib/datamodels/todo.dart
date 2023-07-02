import 'package:json_annotation/json_annotation.dart';
import 'time_stamp_convertor.dart';
part 'todo.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Todo {
  String category;
  String title;
  String description;
  bool completedStatus;
  String type;
  @TimestampConverter()
  DateTime createdAt;
  @TimestampConverter()
  DateTime updatedAt;
  String userId;
  String todoId;

  Todo(this.category, this.title, this.description, this.completedStatus, this.type, this.createdAt, this.updatedAt, this.userId, this.todoId);

  factory Todo.fromJson(Map<String, dynamic> json) =>
      _$TodoFromJson(json);
  Map<String, dynamic> toJson() => _$TodoToJson(this);
}
