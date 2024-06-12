import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/app/bindings/todo_bindings.dart';
import 'package:todo_app/app/routes/app_pages.dart';
import 'package:todo_app/app/routes/app_routes.dart';
import 'package:todo_app/core/constants/app_strings.dart';
import 'package:todo_app/core/init/dependecy_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.todoView,
      getPages: AppPages.pages,
      initialBinding: TodoBinding(),
    );
  }
}
