part of 'todo_bloc.dart';

abstract class TodoEvent {}

class CreateTodoEvent extends TodoEvent {
  final BuildContext context;
  CreateTodoEvent({required this.context});
}

class UpdateTodoEvent extends TodoEvent {
  final BuildContext context;
  final int id;
  UpdateTodoEvent({required this.context, required this.id});
}

class FetchTodoEvent extends TodoEvent {}

class DeleteTodoEvent extends TodoEvent {
  final int id;
  DeleteTodoEvent({required this.id});
}

class AutoFillTodoEvent extends TodoEvent {
  final TodoModel todoModel;

  AutoFillTodoEvent({required this.todoModel});
}

class ClearFormEvent extends TodoEvent {}

class SearchTodoEvent extends TodoEvent {
  final String query;

  SearchTodoEvent({required this.query});
}

class OnTitleChangeEvent extends TodoEvent {
  final String title;

  OnTitleChangeEvent({required this.title});
}

class OnDescriptionChangeEvent extends TodoEvent {
  final String description;

  OnDescriptionChangeEvent({required this.description});
}

class OnCompletionMinuteChangeEvent extends TodoEvent {
  final int completionMinute;

  OnCompletionMinuteChangeEvent({
    required this.completionMinute,
  });
}

class OnCompletionSecondChangeEvent extends TodoEvent {
  final int completionSecond;

  OnCompletionSecondChangeEvent({
    required this.completionSecond,
  });
}
