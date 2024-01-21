import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_demo/config/injection/di.dart';
import 'package:todo_demo/core/consts/consts.dart';
import 'package:todo_demo/core/core.dart';
import 'package:todo_demo/core/helper/helper.dart';
import 'package:todo_demo/features/todo/model/add_todo_model.dart';
import 'package:todo_demo/features/todo/src/todo_details/bloc/todo_details_bloc.dart';

@RoutePage()
class TodoDetailsPage extends StatefulWidget {
  const TodoDetailsPage({super.key});

  @override
  State<TodoDetailsPage> createState() => _TodoDetailsPageState();
}

class _TodoDetailsPageState extends State<TodoDetailsPage> {
  late final todoDetailsBloc;

  @override
  void initState() {
    todoDetailsBloc = di.get<TodoDetailsBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: "Todo Details",
        isBackButton: true,
        onBack: () {
          todoDetailsBloc.add(StopTodoTimer());
        },
      ),
      body: BlocBuilder<TodoDetailsBloc, TodoDetailsState>(
          builder: (context, state) {
        if (state.status == StateStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == StateStatus.error) {
          return const Center(child: Text("Data Not Available"));
        } else if (state.status == StateStatus.success && state.todo == null) {
          return const Center(child: Text("Data Not Found!"));
        }

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity),
              Text(
                getTimerString(state.todo!),
                style: FontUtilities.style(
                  fontSize: 50,
                  fontWeight: FWT.bold,
                  fontColor: state.todo!.status == TodoStatus.done
                      ? ColorTheme.grey
                      : ColorTheme.blackColor,
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<TodoDetailsBloc, TodoDetailsState>(
                bloc: todoDetailsBloc,
                builder: (context, state) {
                  print(state.todo!.toString());
                  return IconButton(
                    onPressed: (state.todo!.status == TodoStatus.done)
                        ? null
                        : () {
                            if (state.todo!.mode == TodoMode.running) {
                              todoDetailsBloc.add(StopTodoTimer());
                            } else {
                              todoDetailsBloc.add(StartTodoTimer());
                            }
                          },
                    icon: Icon(
                      state.todo!.mode == TodoMode.running
                          ? Icons.pause_circle_filled_outlined
                          : Icons.play_circle_filled_outlined,
                      size: 70,
                      color: state.todo!.status == TodoStatus.done
                          ? ColorTheme.grey
                          : ColorTheme.blackColor,
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    _text("Title", state.todo!.title),
                    _text("Description", state.todo!.description),
                    _text(
                      "Status",
                      state.todo!.status.name.toUpperCase(),
                      color: state.todo!.status == TodoStatus.todo
                          ? ColorTheme.grey
                          : state.todo!.status == TodoStatus.inProgress
                              ? ColorTheme.orange
                              : ColorTheme.green,
                    ),
                    const Divider(
                      color: ColorTheme.grey,
                      thickness: 1,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Column _text(String key, String value, {Color? color}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          color: ColorTheme.grey,
          thickness: 1,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "$key : ",
                style: FontUtilities.style(
                  fontSize: 14,
                  fontColor: ColorTheme.darkGrey,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                value,
                style: FontUtilities.style(
                  fontSize: 14,
                  fontWeight: FWT.bold,
                  fontColor: color ?? ColorTheme.blackColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
