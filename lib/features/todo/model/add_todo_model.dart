import 'dart:convert';

enum TodoStatus {
  todo,
  inProgress,
  done;

  const TodoStatus();

  static TodoStatus get(String value) {
    if (value == 'TodoStatus.todo') {
      return TodoStatus.todo;
    } else if (value == 'TodoStatus.inProgress') {
      return TodoStatus.inProgress;
    } else {
      return TodoStatus.done;
    }
  }
}

enum TodoMode {
  running,
  paused,
  stopped;

  const TodoMode();

  static TodoMode get(String value) {
    if (value == 'TodoMode.stopped') {
      return TodoMode.stopped;
    } else if (value == 'TodoMode.running') {
      return TodoMode.running;
    } else {
      return TodoMode.paused;
    }
  }
}

class TodoModel {
  int? id;
  String title;
  String description;
  Duration completionTime;
  TodoStatus status;
  TodoMode mode;

  TodoModel({
    this.id,
    this.status = TodoStatus.todo,
    this.mode = TodoMode.stopped,
    required this.title,
    required this.description,
    required this.completionTime,
  });

  factory TodoModel.def() => TodoModel(
        title: '',
        description: '',
        completionTime: Duration.zero,
        id: null,
        status: TodoStatus.todo,
        mode: TodoMode.stopped,
      );

  TodoModel copyWith({
    String? title,
    String? description,
    Duration? completionTime,
    TodoStatus? status,
    TodoMode? mode,
    DateTime? timerStartTime,
  }) {
    return TodoModel(
      title: title ?? this.title,
      description: description ?? this.description,
      completionTime: completionTime ?? this.completionTime,
      status: status ?? this.status,
      mode: mode ?? this.mode,
      id: id,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'completionTime': completionTime.inSeconds,
        'id': id,
        'status': status.toString(),
        'mode': mode.toString(),
      };

  @override
  String toString() => jsonEncode(toJson());
}
