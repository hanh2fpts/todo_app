import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/overview_cubit/overview_cubit.dart';
import 'package:todo/screens/global_widget/modifier_item_todo_widget.dart';
import '../global_widget/item_todo_widget.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<OverviewCubit, OverviewState>(
        builder: (context, state) {
          var status = state.status;
          var listTodos = state.listTodos.reversed.toList();
          if (status == OverviewStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (status == OverviewStatus.success && listTodos.isEmpty) {
            return const Center(
              child: Text('Click button to add new task'),
            );
          }
          return ListView.builder(
            itemCount: listTodos.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var item = listTodos[index];
              return Dismissible(
                background: Container(
                  color: Colors.red,
                  child: const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.delete),
                      )),
                ),
                direction: DismissDirection.endToStart,
                confirmDismiss: (DismissDirection direction) async {
                  var confirmed = true;
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('Delete Task'),
                    duration: const Duration(seconds: 5),
                    action: SnackBarAction(label: 'Undo', onPressed: () => confirmed = false),
                  ));
                  return confirmed;
                },
                key: Key(item.id),
                onDismissed: (direction) => context.read<OverviewCubit>().deleteTask(item),
                child: ItemTodoWidget(
                  todoItem: listTodos[index],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            CupertinoModalPopupRoute(builder: (context) => const ModifierItemTodoWidget())),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
