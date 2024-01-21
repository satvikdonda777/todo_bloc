import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_demo/config/injection/di.dart';
import 'package:todo_demo/core/core.dart';
import 'package:todo_demo/core/input_fields/custom_dropdown_filed.dart';
import 'package:todo_demo/features/todo/model/add_todo_model.dart';
import 'package:todo_demo/features/todo/src/todo_list/bloc/todo_bloc.dart';

class AddTodoBottomSheet extends StatefulWidget {
  final TodoModel? todoModel;
  const AddTodoBottomSheet({this.todoModel, super.key});

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  late final todoBloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    todoBloc = di.get<TodoBloc>();
    if (widget.todoModel != null) {
      todoBloc.add(AutoFillTodoEvent(todoModel: widget.todoModel!));
    } else {
      todoBloc.add(ClearFormEvent());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height,
      width: screenSize.width,
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Container(
            height: 5,
            width: 80,
            decoration: BoxDecoration(
              color: ColorTheme.blackColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Center(
            child: Text(
              "ADD TODO",
              style: FontUtilities.style(fontSize: 18, fontWeight: FWT.medium),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: BlocBuilder<TodoBloc, TodoState>(
                  bloc: todoBloc,
                  builder: (context, state) {
                    return Column(
                      children: [
                        CustomTextField(
                          labelText: "Title",
                          hintText: "Enter Title",
                          initialValue: widget.todoModel?.title ?? '',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Title is required";
                            }
                            return null;
                          },
                          onChange: (value) {
                            todoBloc
                                .add(OnTitleChangeEvent(title: value ?? ''));
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextField(
                          labelText: "Description",
                          hintText: "Enter Description",
                          initialValue: widget.todoModel?.description ?? '',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Description is required";
                            }
                            return null;
                          },
                          onChange: (value) {
                            todoBloc.add(OnDescriptionChangeEvent(
                                description: value ?? ''));
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomDropdownField(
                              labelText: "Completion Minute",
                              hintText: "Select Completion Minute",
                              items: List.generate(5, (index) => index),
                              valueSuffix: 'Minute',
                              value: (state.addTodoModel?.completionTime
                                          .inMinutes ??
                                      0) %
                                  60,
                              validator: (value) {
                                if (value == null ||
                                    (state.addTodoModel?.completionTime
                                                .inSeconds ==
                                            0 &&
                                        value == 0)) {
                                  return "Completion Minute is required";
                                }
                                return null;
                              },
                              onChange: (value) {
                                todoBloc.add(
                                  OnCompletionMinuteChangeEvent(
                                    completionMinute: value,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 10),
                            CustomDropdownField(
                              labelText: "Completion Second",
                              hintText: "Select Completion Second",
                              valueSuffix: 'Second',
                              items: List.generate(60, (index) => index),
                              value: (state.addTodoModel?.completionTime
                                          .inSeconds ??
                                      0) %
                                  60,
                              validator: (value) {
                                if (value == null ||
                                    (state.addTodoModel?.completionTime
                                                .inMinutes ==
                                            0 &&
                                        value == 0)) {
                                  return "Completion Second is required";
                                }
                                return null;
                              },
                              onChange: (value) {
                                todoBloc.add(
                                  OnCompletionSecondChangeEvent(
                                    completionSecond: value,
                                  ),
                                );
                              },
                            )
                          ],
                        )
                      ],
                    );
                  }),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CustomFlatButton(
                    isOutlined: true,
                    onPressed: () {
                      todoBloc.add(ClearFormEvent());
                    },
                    title: "CLEAR"),
                const SizedBox(width: 10),
                CustomFlatButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (widget.todoModel != null) {
                        todoBloc.add(
                          UpdateTodoEvent(
                            context: context,
                            id: widget.todoModel!.id!,
                          ),
                        );
                      } else {
                        todoBloc.add(CreateTodoEvent(context: context));
                      }
                    }
                  },
                  title:
                      widget.todoModel != null ? "UPDATE TODO" : "CREATE TODO",
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
