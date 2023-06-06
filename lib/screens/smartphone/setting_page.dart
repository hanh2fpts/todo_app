import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/theme_cubit/theme_cubit.dart';
import 'package:todo/model/todo_model.dart';
import 'package:todo/pigeon.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TodoModel> listTodo = [];
    return Scaffold(body: Center(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return ListView(children: [
            ListTile(
                leading: const Icon(Icons.sunny),
                title: const Text('Change dark theme'),
                trailing: CupertinoSwitch(
                    value: state.isDark,
                    onChanged: (value) => context.read<ThemeCubit>().changeTheme(value))),
            ListTile(
                leading: const Icon(Icons.now_widgets),
                title: const Text('Add widget'),
                trailing: CupertinoSwitch(value: true, onChanged: (value) => {
                  value ? HomeWidgetMessageApi().addHomeWidget(listTodo) : HomeWidgetMessageApi().addHomeWidget([])
                }))
          ]);
        },
      ),
    ));
  }
}
