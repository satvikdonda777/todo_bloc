import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_demo/features/todo/model/add_todo_model.dart';

class HiveManager {
  static Future<bool> createTodo(TodoModel data) async {
    try {
      Box todoBox = await Hive.openBox(HiveBox.todoBox);
      await todoBox.add(data.toString());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<Map?> getTodo() async {
    try {
      Box todoBox = await Hive.openBox(HiveBox.todoBox);
      return todoBox.toMap();
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<bool> deleteTodo(int id) async {
    try {
      Box todoBox = await Hive.openBox(HiveBox.todoBox);
      await todoBox.delete(id);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> updateTodo(int id, TodoModel updatedData) async {
    try {
      Box todoBox = await Hive.openBox(HiveBox.todoBox);
      await todoBox.put(id, updatedData.toString());
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}

class HiveBox {
  static const String todoBox = 'TodoBox';
}
