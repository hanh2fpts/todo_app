import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:todo/cubit/overview_cubit/overview_cubit.dart';
import 'package:todo/cubit/status_cubit/status_cubit.dart';
import 'package:todo/screens/smartphone/status_page.dart';
import 'package:todo/screens/tablet/home_page_tl.dart';
import 'package:todo/screens/global_widget/modifier_item_todo_widget.dart';
import 'cubit/home_cubit/home_cubit.dart';
import 'cubit/theme_cubit/theme_cubit.dart';
import 'screens/smartphone/home_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final quickActions = const QuickActions();
  @override
  void initState() {
    quickActions.setShortcutItems(const [
      ShortcutItem(type: 'new_task', localizedTitle: 'Add New Task', icon: 'icon_add'),
      ShortcutItem(type: 'status', localizedTitle: 'Status', icon: 'icon_status')
    ]);
    quickActions.initialize((type) {
      switch (type) {
        case 'new_task':
          Navigator.push(context,
              CupertinoModalPopupRoute(builder: (context) => const ModifierItemTodoWidget()));
          break;
        case 'status':
          Navigator.push(
              context, CupertinoModalPopupRoute(builder: (context) => const StatusPage()));
          break;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()..getCurrentTheme()),
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => OverviewCubit()..initData()),
        BlocProvider(create: (context) => StatusCubit())
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: state.currentTheme,
            home: checkScreenSize(context) != 'COMPACT' ? const MyHomePageTl() : const MyHomePage(),
          );
        },
      ),
    );
  }
}

String checkScreenSize(BuildContext context) {
  final widthScreen = MediaQuery.of(context).size.width;
  if (widthScreen < 600) {
    return 'COMPACT';
  }
  if (widthScreen > 600 && widthScreen < 840) {
    return 'MEDIUM';
  }
  return 'EXPANDED';
}
