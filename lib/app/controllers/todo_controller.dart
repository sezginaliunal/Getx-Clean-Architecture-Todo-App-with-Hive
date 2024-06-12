import 'package:get/get.dart';
import 'package:todo_app/app/models/todo.dart';
import 'package:todo_app/app/services/todo_cache_services.dart';
import 'package:todo_app/core/constants/hive_constant.dart';

class TodoController extends GetxController {
  RxList<Todo> todos = <Todo>[].obs;
  late TodoCacheServices _todoCacheServices;

  @override
  void onInit() {
    super.onInit();
    _todoCacheServices = TodoCacheServices(HiveKeys.todo);
    _initializeCache();
  }

  Future<void> _initializeCache() async {
    await _todoCacheServices.init();
    await loadTodos();
  }

  Future<void> loadTodos() async {
    final cachedTodos = await _todoCacheServices.getValues();
    if (cachedTodos != null) {
      todos.assignAll(cachedTodos);
    }
  }

  Future<void> addTodo(Todo todo) async {
    await _todoCacheServices.putItem(todo.name, todo);
    todos.add(todo);
  }

  Future<void> removeTodoByName(String name) async {
    await _todoCacheServices.removeItem(name);
    todos.removeWhere((todo) => todo.name == name);
  }

  Future<void> updateTodo(Todo todo) async {
    await _todoCacheServices.putItem(
        todo.name, todo); // Anahtar olarak name kullanılıyor
    int index = todos.indexWhere((element) => element.name == todo.name);
    if (index != -1) {
      todos[index] = todo;
      todos.refresh(); // GetX list refresh
    }
  }

  Todo? getTodoByName(String name) {
    return _todoCacheServices.getItem(name);
  }
}
