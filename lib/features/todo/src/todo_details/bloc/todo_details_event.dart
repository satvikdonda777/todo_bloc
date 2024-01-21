part of 'todo_details_bloc.dart';

abstract class TodoDetailsEvent {}

class SetInitState extends TodoDetailsEvent {
  final TodoModel todoModel;

  SetInitState({required this.todoModel});
}

class StartTodoTimer extends TodoDetailsEvent {}

class StopTodoTimer extends TodoDetailsEvent {}
