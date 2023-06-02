import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/overview_cubit/overview_cubit.dart';
import 'package:todo/cubit/status_cubit/status_cubit.dart';
import 'cubit/home_cubit/home_cubit.dart';
import 'cubit/theme_cubit/theme_cubit.dart';
import 'screens/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
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
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}
