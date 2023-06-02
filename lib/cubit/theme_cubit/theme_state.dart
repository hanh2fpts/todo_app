part of 'theme_cubit.dart';

final class ThemeState extends Equatable {
  final ThemeData currentTheme;
  final bool isDark;
  const ThemeState(this.currentTheme, this.isDark);

  @override
  List<Object> get props => [currentTheme, isDark];
}
