import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/utils/theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(FlutterTodosTheme.dark, true));
  void getCurrentTheme() async {
    bool? isDark = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool('currentDarkTheme');
    if (isDark == null) {
      await prefs.setBool('currentDarkTheme', true);
      isDark = true;
    }
    emit(ThemeState(isDark ? FlutterTodosTheme.dark : FlutterTodosTheme.light, isDark));
  }

  void changeTheme(bool isDark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark
        ? emit(ThemeState(FlutterTodosTheme.dark, isDark))
        : emit(ThemeState(FlutterTodosTheme.light, isDark));
    prefs.setBool('currentDarkTheme', isDark);
  }
}
