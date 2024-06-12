import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/controllers/todo_controller.dart';
import 'package:todo_app/app/models/todo.dart';

class TodoView extends GetView<TodoController> {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Obx(() {
        if (controller.todos.isEmpty) {
          return const Center(child: Text('No todos available'));
        }
        return ListView.builder(
          itemCount: controller.todos.length,
          itemBuilder: (context, index) {
            final todo = controller.todos[index];
            return ListTile(
              title: Text(todo.name),
              subtitle: Text(todo.description ?? 'No description'),
              trailing: Checkbox(
                value: todo.isCompleted,
                onChanged: (bool? value) {
                  controller.updateTodo(Todo(
                    name: todo.name,
                    description: todo.description,
                    isCompleted: value ?? false,
                  ));
                },
              ),
              onLongPress: () {
                controller.removeTodoByName(todo.name);
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Yeni todo eklemek için bir dialog veya yeni bir sayfa açabilirsiniz
          showDialog(
            context: context,
            builder: (context) {
              String name = '';
              String? description;
              return AlertDialog(
                title: const Text('Add Todo'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Name'),
                      onChanged: (value) => name = value,
                    ),
                    TextField(
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      onChanged: (value) => description = value,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (name.isNotEmpty) {
                        controller.addTodo(Todo(
                          name: name,
                          description: description,
                          isCompleted: false,
                        ));
                        Get.back();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
