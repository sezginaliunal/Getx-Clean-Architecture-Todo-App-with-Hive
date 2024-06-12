import 'package:hive/hive.dart';
import 'package:todo_app/core/constants/hive_constant.dart';

part 'todo.g.dart';

@HiveType(typeId: HiveConstants.todoTypeId)
class Todo {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String? description;
  @HiveField(2)
  final bool isCompleted;

  Todo({
    required this.name,
    this.description,
    required this.isCompleted,
  });
}
