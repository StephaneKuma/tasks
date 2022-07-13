part of 'theme_cubit.dart';

enum ThemeStatus { light, dark }

// ignore: must_be_immutable
class ThemeState extends Equatable {
  ThemeState._({
    required this.status,
    this.isDark,
    this.theme,
  }) {
    _init();
  }

  void _init() async {
    var prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('isDark')) {
      prefs.setBool('isDark', false);
    }

    isDark = prefs.getBool('isDark')!;
  }

  ThemeState.light() : this._(status: ThemeStatus.light, theme: lightTheme());

  ThemeState.dark() : this._(status: ThemeStatus.dark, theme: darkTheme());

  final ThemeStatus status;
  bool? isDark;
  ThemeData? theme;

  @override
  List<Object?> get props => [status, isDark, theme];
}
