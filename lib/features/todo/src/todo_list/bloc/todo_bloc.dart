import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_demo/core/consts/consts.dart';
import 'package:todo_demo/features/todo/model/add_todo_model.dart';
import 'package:todo_demo/features/todo/repo/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState()) {
    on<CreateTodoEvent>(_createTodo);
    on<UpdateTodoEvent>(_updateTodo);
    on<FetchTodoEvent>(_fetchTodo);
    on<DeleteTodoEvent>(_deleteTodo);
    on<AutoFillTodoEvent>(_autoFill);
    on<ClearFormEvent>(_clearForm);
    on<SearchTodoEvent>(_searchTodo);

    // Form Events.
    // Title
    on<OnTitleChangeEvent>((event, emit) {
      emit(state.copyWith(
          addTodoModel: state.addTodoModel?.copyWith(title: event.title)));
    });

    // Description
    on<OnDescriptionChangeEvent>((event, emit) {
      emit(state.copyWith(
          addTodoModel:
              state.addTodoModel?.copyWith(description: event.description)));
    });

    // Minute
    on<OnCompletionMinuteChangeEvent>((event, emit) {
      Duration duration = state.addTodoModel?.completionTime ?? Duration.zero;

      duration = Duration(
        minutes: event.completionMinute,
        seconds: duration.inSeconds % 60,
      );

      emit(
        state.copyWith(
          addTodoModel: state.addTodoModel?.copyWith(completionTime: duration),
        ),
      );
    });

    // Seconds
    on<OnCompletionSecondChangeEvent>((event, emit) {
      Duration duration = state.addTodoModel?.completionTime ?? Duration.zero;

      duration = Duration(
        minutes: duration.inSeconds ~/ 60,
        seconds: event.completionSecond,
      );

      emit(
        state.copyWith(
          addTodoModel: state.addTodoModel?.copyWith(completionTime: duration),
        ),
      );
    });
  }

  // create new todo
  Future<bool> _createTodo(
      CreateTodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));

    TodoRepository todoRepo = TodoRepositoryImpl();
    bool isSuccess = await todoRepo.createTodo(state.addTodoModel!.copyWith(
      status: TodoStatus.todo,
      mode: TodoMode.stopped,
    ));

    if (isSuccess) {
      emit(state.copyWith(status: StateStatus.success));
      add(FetchTodoEvent());
      await event.context.router.pop();
      return true;
    }

    emit(state.copyWith(status: StateStatus.error));
    return false;
  }

  // update todo
  Future<bool> _updateTodo(
      UpdateTodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));

    TodoRepository todoRepo = TodoRepositoryImpl();
    bool isSuccess = await todoRepo.updateTodo(
        event.id,
        state.addTodoModel!.copyWith(
          status: TodoStatus.todo,
          mode: TodoMode.stopped,
        ));

    if (isSuccess) {
      emit(state.copyWith(status: StateStatus.success));
      add(FetchTodoEvent());
      await event.context.router.pop();
      return true;
    }

    emit(state.copyWith(status: StateStatus.error));
    return false;
  }

  // get list of todo
  Future<void> _fetchTodo(FetchTodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));

    TodoRepository todoRepo = TodoRepositoryImpl();
    final Map? response = await todoRepo.getTodo();

    if (response == null) {
      emit(state.copyWith(status: StateStatus.error));
      return;
    } else {
      if (response.isEmpty) {
        emit(state.copyWith(status: StateStatus.empty));
        return;
      }
    }

    List<TodoModel> tmpTodoList = [];

    response.forEach(
      (key, value) {
        Map data = jsonDecode(value);

        tmpTodoList.add(
          TodoModel(
            id: key,
            title: data['title'],
            description: data['description'],
            completionTime: Duration(seconds: data['completionTime']),
            mode: TodoMode.get(data['mode']),
            status: TodoStatus.get(data['status']),
          ),
        );
      },
    );

    emit(state.copyWith(todoList: tmpTodoList, status: StateStatus.success));
  }

  // Delete Todo
  Future<void> _deleteTodo(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));

    TodoRepository todoRepo = TodoRepositoryImpl();
    bool isSuccess = await todoRepo.deleteTodo(event.id);

    if (isSuccess) {
      emit(state.copyWith(status: StateStatus.success));
      add(FetchTodoEvent());
      return;
    }

    emit(state.copyWith(status: StateStatus.error));
  }

  // Auto Fill Form
  Future<void> _autoFill(
      AutoFillTodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(addTodoModel: event.todoModel));
  }

  // Clear Form
  Future<void> _clearForm(ClearFormEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(addTodoModel: TodoModel.def()));
  }

  // Search Todo
  Future<void> _searchTodo(
      SearchTodoEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));

    TodoRepository todoRepo = TodoRepositoryImpl();
    final Map? response = await todoRepo.getTodo();

    if (response == null) {
      emit(state.copyWith(status: StateStatus.error));
      return;
    } else {
      if (response.isEmpty) {
        emit(state.copyWith(status: StateStatus.empty));
        return;
      }
    }

    List<TodoModel> tmpTodoList = [];

    response.forEach(
      (key, value) {
        Map data = jsonDecode(value);

        if (data['title']
                .toString()
                .toLowerCase()
                .contains(event.query.toLowerCase()) ||
            data['description']
                .toString()
                .toLowerCase()
                .contains(event.query.toLowerCase())) {
          tmpTodoList.add(
            TodoModel(
              id: key,
              title: data['title'],
              description: data['description'],
              completionTime: Duration(seconds: data['completionTime']),
              mode: TodoMode.get(data['mode']),
              status: TodoStatus.get(data['status']),
            ),
          );
        }
      },
    );

    if (tmpTodoList.isEmpty) {
      emit(state.copyWith(status: StateStatus.empty));
      return;
    }

    emit(state.copyWith(todoList: tmpTodoList, status: StateStatus.success));
  }
}
