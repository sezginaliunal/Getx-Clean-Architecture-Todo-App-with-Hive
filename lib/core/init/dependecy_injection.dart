import 'package:hive_flutter/hive_flutter.dart';

class DependencyInjection {
  static Future<void> init() async {
    await Hive.initFlutter();
  }
}
