import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_demo/config/injection/di.dart';
import 'package:todo_demo/core/consts/consts.dart';
import 'package:todo_demo/features/todo/model/add_todo_model.dart';
import 'package:todo_demo/features/todo/repo/todo_repository.dart';
import 'package:todo_demo/features/todo/src/todo_list/bloc/todo_bloc.dart';
import 'package:todo_demo/main.dart';

part 'todo_details_event.dart';
part 'todo_details_state.dart';

class TodoDetailsBloc extends Bloc<TodoDetailsEvent, TodoDetailsState> {
  TodoDetailsBloc() : super(TodoDetailsState()) {
    on<SetInitState>(_setInitState);
    on<StartTodoTimer>(_startTodoTimer);
    on<StopTodoTimer>(_stopTodoTimer);
  }
  // Timer
  bool isTimerRunning = false;

  Future<void> _setInitState(
    SetInitState event,
    Emitter<TodoDetailsState> emit,
  ) async {
    emit(state.copyWith(todo: event.todoModel));
  }

  Future<void> _startTodoTimer(
      StartTodoTimer event, Emitter<TodoDetailsState> emit) async {
    isTimerRunning = true;
    while (isTimerRunning) {
      if (state.todo!.completionTime.inSeconds <= 0) {
        _stopTodoTimer(StopTodoTimer(), emit);
      }
      await Future.delayed(const Duration(seconds: 1));
      if (!isTimerRunning) break;
      emit(
        state.copyWith(
          todo: state.todo!.copyWith(
            status: TodoStatus.inProgress,
            mode: TodoMode.running,
            completionTime:
                state.todo!.completionTime - const Duration(seconds: 1),
          ),
        ),
      );

      TodoRepository todoRepo = TodoRepositoryImpl();
      await todoRepo.updateTodo(state.todo!.id!, state.todo!);
    }
    flutterLocalNotificationsPlugin.show(
      1,
      'Todo Status Changed!',
      'Todo Status Changed From `STOPPED` to `RUNNING`',
      const NotificationDetails(
          android: AndroidNotificationDetails("1", "dffsd")),
    );
  }

  Future<void> _stopTodoTimer(
      StopTodoTimer event, Emitter<TodoDetailsState> emit) async {
    isTimerRunning = false;

    TodoStatus status = TodoStatus.inProgress;
    TodoMode mode = TodoMode.paused;

    if (state.todo!.completionTime.inSeconds <= 0) {
      status = TodoStatus.done;
      mode = TodoMode.stopped;
    }

    emit(state.copyWith(
      todo: state.todo!.copyWith(
        status: status,
        mode: mode,
      ),
    ));

    TodoRepository todoRepo = TodoRepositoryImpl();
    await todoRepo.updateTodo(state.todo!.id!, state.todo!);
    TodoBloc todoBloc = di.get<TodoBloc>();
    todoBloc.add(FetchTodoEvent());

    flutterLocalNotificationsPlugin.show(
      1,
      'Todo Status Changed!',
      'Todo Status Changed From `RUNNING` to `${status.name.toUpperCase()}`',
      const NotificationDetails(
          android: AndroidNotificationDetails("1", "dffsd")),
    );
  }
}
