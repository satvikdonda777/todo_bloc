part of 'todo_bloc.dart';

@immutable
class TodoState implements Equatable {
  StateStatus status;
  TodoModel? addTodoModel;
  List<TodoModel>? todoList;

  TodoState({
    this.status = StateStatus.initial,
    this.addTodoModel,
    this.todoList,
  }) {
    addTodoModel ??= TodoModel.def();
    todoList ??= [];
  }

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify {
    return null;
  }

  TodoState copyWith({
    StateStatus? status,
    TodoModel? addTodoModel,
    List<TodoModel>? todoList,
  }) {
    return TodoState(
      status: status ?? this.status,
      addTodoModel: addTodoModel ?? this.addTodoModel,
      todoList: todoList ?? this.todoList,
    );
  }
}
