part of 'todo_details_bloc.dart';

class TodoDetailsState implements Equatable {
  final StateStatus status;
  final TodoModel? todo;

  TodoDetailsState({
    this.status = StateStatus.initial,
    this.todo,
  });

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;

  TodoDetailsState copyWith({
    StateStatus? status,
    TodoModel? todo,
  }) {
    return TodoDetailsState(
      status: status ?? this.status,
      todo: todo ?? this.todo,
    );
  }
}
