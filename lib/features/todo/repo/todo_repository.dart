import 'package:todo_demo/config/db/hive/hive_manager.dart';
import 'package:todo_demo/features/todo/model/add_todo_model.dart';

abstract class TodoRepository {
  Future<bool> createTodo(TodoModel model);
  Future<Map?> getTodo();
  Future<bool> deleteTodo(int id);
  Future<bool> updateTodo(int id, TodoModel model);
}

class TodoRepositoryImpl extends TodoRepository {
  @override
  Future<bool> createTodo(TodoModel model) async {
    return HiveManager.createTodo(model);
  }

  @override
  Future<Map?> getTodo() async {
    return await HiveManager.getTodo();
  }

  @override
  Future<bool> deleteTodo(int id) async {
    return await HiveManager.deleteTodo(id);
  }

  @override
  Future<bool> updateTodo(
    int id,
    TodoModel model,
  ) async {
    return await HiveManager.updateTodo(id, model);
  }
}
