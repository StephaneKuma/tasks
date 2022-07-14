import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'colors.dart';
part 'styles.dart';

ThemeData lightTheme() => ThemeData(
      backgroundColor: kcWhiteColor,
      primaryColor: kcWhiteColor,
      appBarTheme: const AppBarTheme(
        color: kcWhiteColor,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.grey[700],
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      brightness: Brightness.light,
    );

ThemeData darkTheme() => ThemeData(
      backgroundColor: kcDarkGreyColor,
      primaryColor: kcDarkGreyColor,
      appBarTheme: const AppBarTheme(
        color: kcDarkGreyColor,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.grey[100],
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      brightness: Brightness.dark,
    );
