import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/app/models/todo.dart';
import 'package:todo_app/core/constants/hive_constant.dart';
import 'package:todo_app/core/services/base_cache.dart';

class TodoCacheServices extends ICacheManager<Todo> {
  TodoCacheServices(super.key);

  @override
  Future<void> addItems(List<Todo> items) async {
    for (var item in items) {
      await box?.add(item);
    }
  }

  @override
  Todo? getItem(String key) {
    return box?.get(key);
  }

  @override
  Future<List<Todo>?> getValues() async {
    return box?.values.toList();
  }

  @override
  Future<void> putItem(String key, Todo item) async {
    await box?.put(key, item);
  }

  @override
  Future<void> putItems(List<Todo> items) async {
    final Map<String, Todo> itemsMap = {
      for (var item in items) item.name: item
    };
    await box?.putAll(itemsMap);
  }

  @override
  void registerAdapters() {
    if (!Hive.isAdapterRegistered(HiveConstants.todoTypeId)) {
      Hive.registerAdapter(TodoAdapter());
    }
  }

  @override
  Future<void> removeItem(String key) async {
    await box?.delete(key);
  }
}
