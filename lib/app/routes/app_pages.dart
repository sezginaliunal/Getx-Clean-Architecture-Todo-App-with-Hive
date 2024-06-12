import 'package:get/get.dart';
import 'package:todo_app/app/bindings/todo_bindings.dart';
import 'package:todo_app/app/routes/app_routes.dart';
import 'package:todo_app/app/view/todo_view.dart';

class AppPages {
  static final todoView = GetPage(
      name: AppRoutes.todoView,
      page: () => const TodoView(),
      binding: TodoBinding());

  static final List<GetPage> pages = [
    todoView,
  ];
}
