import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/theme_cubit/theme_cubit.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return ListTile(
              leading: const Icon(Icons.sunny),
              title: const Text('Change dark theme'),
              trailing: CupertinoSwitch(
                  value:  state.isDark,
                  onChanged: (value) => context.read<ThemeCubit>().changeTheme(value)));
        },
      ),
    ));
  }
}
