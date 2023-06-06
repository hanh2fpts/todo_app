import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/overview_cubit/overview_cubit.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/screens/global_widget/modifier_item_todo_widget.dart';

class ItemTodoWidget extends StatelessWidget {
  const ItemTodoWidget({super.key, required this.todoItem});
  final TodoModel todoItem;
  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    if (widthScreen > 600) {
      return Card(
        margin: const EdgeInsets.all(30),
        color: Colors.deepPurple.shade300,
        child: SizedBox(
          height: 100,
          width: 100,
          child: Column(
            children: [
              Text(todoItem.title),
            ],
          ),
        ),
      );
    } else {
      return ListTile(
        onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => const ModifierItemTodoWidget(),
                settings: RouteSettings(arguments: todoItem))),
        leading: Checkbox(
            value: todoItem.isCompleted,
            onChanged: (value) => context.read<OverviewCubit>().makeTaskCompleted(todoItem.id)),
        title: Text(
          todoItem.title.toString(),
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          todoItem.description.toString(),
          style: const TextStyle(fontSize: 20),
        ),
      );
    }
  }
}
