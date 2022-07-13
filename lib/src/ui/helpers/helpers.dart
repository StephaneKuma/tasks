import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'colors.dart';
part 'styles.dart';

ThemeData lightTheme() => ThemeData(
      backgroundColor: kcWhiteColor,
      primaryColor: kcWhiteColor,
      appBarTheme: const AppBarTheme(color: kcWhiteColor),
      brightness: Brightness.light,
    );

ThemeData darkTheme() => ThemeData(
      backgroundColor: kcDarkGreyColor,
      primaryColor: kcDarkGreyColor,
      brightness: Brightness.dark,
    );
