part of 'theme_cubit.dart';

enum ThemeStatus { light, dark }

class ThemeState extends Equatable {
  const ThemeState._({
    required this.status,
    required this.isDark,
    required this.theme,
  });

  ThemeState.light() : this._(status: ThemeStatus.light, isDark: false, theme: lightTheme());

  ThemeState.dark() : this._(status: ThemeStatus.dark, isDark: true, theme: darkTheme());

  final ThemeStatus status;
  final bool isDark;
  final ThemeData theme;

  @override
  List<Object> get props => [status, isDark, theme];
}
