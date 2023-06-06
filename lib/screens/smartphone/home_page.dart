import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/home_cubit/home_cubit.dart';
import 'package:todo/cubit/overview_cubit/overview_cubit.dart';
import 'package:todo/cubit/status_cubit/status_cubit.dart';
import 'package:todo/screens/smartphone/setting_page.dart';
import 'package:todo/screens/smartphone/status_page.dart';
import 'package:todo/screens/smartphone/overview_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> pages = const [OverviewPage(), StatusPage(), SettingPage()];
  final List<Text> titles = const [Text('Todos'), Text('Status'), Text('Setting')];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: titles[state],
            actions: state == 0
                ? [
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
                  ]
                : [],
          ),
          body: IndexedStack(index: state, children: pages),
          bottomNavigationBar: NavigationBar(
              selectedIndex: state,
              onDestinationSelected: (value) {
                context.read<HomeCubit>().selectTab(value);
                if (value == 1) {
                  var listTodo = context.read<OverviewCubit>().listTodos;
                  int comp = 0;
                  int active = 0;
                  for (var element in listTodo) {
                    if (element.isCompleted == true) {
                      comp++;
                    } else {
                      active++;
                    }
                  }
                  context.read<StatusCubit>().getStatus(comp, active);
                }
              },
              destinations: const [
                NavigationDestination(icon: Icon(CupertinoIcons.list_bullet), label: 'Todos'),
                NavigationDestination(icon: Icon(Icons.show_chart), label: 'Status'),
                NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
              ]),
        );
      },
    );
  }
}
