import 'package:todo_demo/features/todo/model/add_todo_model.dart';

String getTimerString(TodoModel todoModel) {
  Duration timer = todoModel.completionTime;

  String minute = (timer.inMinutes % 60).toString();
  String second = (timer.inSeconds % 60).toString();

  if (minute.length == 1) minute = '0$minute';
  if (second.length == 1) second = '0$second';

  return '$minute:$second';
}
