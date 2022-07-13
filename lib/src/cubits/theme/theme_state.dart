part of 'theme_cubit.dart';

enum ThemeStatus { light, dark }

class ThemeState extends Equatable {
  const ThemeState._({required this.status, required this.theme});

  ThemeState.light() : this._(status: ThemeStatus.light, theme: lightTheme());

  ThemeState.dark() : this._(status: ThemeStatus.dark, theme: darkTheme());

  final ThemeStatus status;
  final ThemeData theme;

  @override
  List<Object> get props => [status, theme];
}
