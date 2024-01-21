import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_demo/core/core.dart';
import 'package:todo_demo/core/helper/helper.dart';
import 'package:todo_demo/features/todo/model/add_todo_model.dart';

class TodoCardWidget extends StatelessWidget {
  final TodoModel todoModel;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onTap;
  const TodoCardWidget(
      {required this.onDelete,
      required this.onEdit,
      required this.todoModel,
      required this.onTap,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorTheme.whiteColor,
        boxShadow: [
          BoxShadow(
            color: ColorTheme.blackColor.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        minVerticalPadding: 0,
        dense: true,
        title: Text(
          todoModel.title,
          style:
              FontUtilities.style(fontSize: 16, fontWeight: FWT.bold).copyWith(
            decoration: todoModel.status == TodoStatus.done
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
        leading: Container(
          width: 4,
          decoration: BoxDecoration(
            color: todoModel.status == TodoStatus.todo
                ? ColorTheme.grey
                : todoModel.status == TodoStatus.inProgress
                    ? ColorTheme.orange
                    : ColorTheme.green,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        subtitle: Text(
          todoModel.description,
          style: FontUtilities.style(fontSize: 14, fontWeight: FWT.regular)
              .copyWith(
            decoration: todoModel.status == TodoStatus.done
                ? TextDecoration.lineThrough
                : null,
          ),
        ),
        tileColor: ColorTheme.whiteColor,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (todoModel.status != TodoStatus.done) ...{
              Text(
                getTimerString(todoModel),
                style: FontUtilities.style(
                  fontSize: 20,
                  fontWeight: FWT.bold,
                  fontColor: ColorTheme.darkGrey,
                ),
              )
            },
            IconButton(
              onPressed: onEdit,
              icon: const Icon(
                CupertinoIcons.pen,
                color: ColorTheme.blackColor,
                size: 18,
              ),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(
                CupertinoIcons.delete,
                color: ColorTheme.red,
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
