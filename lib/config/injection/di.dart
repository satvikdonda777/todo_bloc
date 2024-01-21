import 'package:get_it/get_it.dart';
import 'package:todo_demo/features/todo/src/todo_details/bloc/todo_details_bloc.dart';
import 'package:todo_demo/features/todo/src/todo_list/bloc/todo_bloc.dart';

final di = GetIt.instance;

class DI {
  static init() {
    di.registerSingleton<TodoBloc>(TodoBloc());
    di.registerSingleton<TodoDetailsBloc>(TodoDetailsBloc());
  }
}
