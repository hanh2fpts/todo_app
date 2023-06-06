import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/overview_cubit/overview_cubit.dart';
import 'package:todo/screens/global_widget/item_todo_widget.dart';
import 'package:todo/screens/global_widget/modifier_item_todo_widget.dart';

class OverviewPageTl extends StatelessWidget {
  const OverviewPageTl({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Todos'),
          actions: [
            PopupMenuButton(
                icon: const Icon(Icons.filter_list),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem<int>(
                        value: 0,
                        child: const Text('Show All'),
                        onTap: () => context.read<OverviewCubit>().filterList(0)),
                    PopupMenuItem<int>(
                      value: 1,
                      child: const Text('Show Actived'),
                      onTap: () => context.read<OverviewCubit>().filterList(1),
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: const Text('Show Completed'),
                      onTap: () => context.read<OverviewCubit>().filterList(2),
                    ),
                  ];
                }),
            PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: const Text('Make all incomplete'),
                  onTap: () => context.read<OverviewCubit>().filterList(3),
                ),
                PopupMenuItem<int>(
                  value: 1,
                  child: const Text('Clear completed'),
                  onTap: () => context.read<OverviewCubit>().filterList(4),
                ),
              ];
            })
          ]),
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
            scrollDirection: Axis.horizontal,
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
                direction: DismissDirection.down,
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
