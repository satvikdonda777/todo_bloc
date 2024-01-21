import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_demo/config/injection/di.dart';
import 'package:todo_demo/config/navigation/app_route.dart';
import 'package:todo_demo/core/consts/consts.dart';
import 'package:todo_demo/core/core.dart';
import 'package:todo_demo/features/todo/src/todo_details/bloc/todo_details_bloc.dart';
import 'package:todo_demo/features/todo/src/todo_list/bloc/todo_bloc.dart';
import 'package:todo_demo/features/todo/widgets/add_todo_bottomsheet.dart';
import 'package:todo_demo/features/todo/widgets/todo_card_widget.dart';

@RoutePage()
class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late final todoBloc;
  late final todoDetailsBloc;

  @override
  void initState() {
    todoBloc = di.get<TodoBloc>();
    todoDetailsBloc = di.get<TodoDetailsBloc>();
    todoBloc.add(FetchTodoEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CupertinoSearchTextField(
                  onChanged: (value) {
                    todoBloc.add(SearchTodoEvent(query: value));
                  },
                ),
              ),
              Expanded(
                child: Center(
                  child: BlocConsumer<TodoBloc, TodoState>(
                    bloc: todoBloc,
                    builder: (context, TodoState state) {
                      if (state.status == StateStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.status == StateStatus.empty) {
                        return Center(
                          child: Text(
                            "No Todo Found.",
                            style: FontUtilities.style(
                                fontSize: 18, fontWeight: FWT.bold),
                          ),
                        );
                      } else if (state.status == StateStatus.error) {
                        return Center(
                            child: Text("Something went wrong.",
                                style: FontUtilities.style(
                                    fontSize: 18, fontWeight: FWT.bold)));
                      } else {
                        return ListView.builder(
                          itemCount: state.todoList!.length,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          itemBuilder: (context, index) {
                            return TodoCardWidget(
                              onTap: () {
                                todoDetailsBloc.add(
                                  SetInitState(
                                    todoModel: state.todoList![index],
                                  ),
                                );
                                context.router.push(
                                  const TodoDetailsPageRoute(),
                                );
                              },
                              onDelete: () {
                                todoBloc.add(
                                  DeleteTodoEvent(
                                    id: state.todoList![index].id!,
                                  ),
                                );
                              },
                              onEdit: () {
                                showBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return AddTodoBottomSheet(
                                      todoModel: state.todoList![index],
                                    );
                                  },
                                );
                              },
                              todoModel: state.todoList![index],
                            );
                          },
                        );
                      }
                    },
                    listener: (_, __) {},
                  ),
                ),
              ),
            ],
          ),

          /// For show floating action button
          Positioned(
            bottom: 10,
            right: 10,
            child: Builder(
              builder: (context) => FloatingActionButton(
                onPressed: () {
                  showBottomSheet(
                    context: context,
                    builder: (context) {
                      return const AddTodoBottomSheet();
                    },
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }
}
