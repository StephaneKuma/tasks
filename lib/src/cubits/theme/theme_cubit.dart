import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/src/ui/helpers/helpers.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  // ignore: prefer_final_fields
  var _prefs = SharedPreferences.getInstance();

  ThemeCubit() : super(ThemeState.light());

  void onChangeTheme({bool? mode}) async {
    if (mode != null) {
      mode ? emit(ThemeState.dark()) : emit(ThemeState.light());
    } else {
      var prefs = await _prefs;
      var key = 'isDark';

      if (prefs.containsKey(key)) {
        var prefMode = prefs.getBool(key)!;

        if (prefMode) {
          prefs.setBool(key, ThemeState.light().isDark);
          emit(ThemeState.light());
        } else {
          prefs.setBool(key, ThemeState.dark().isDark);
          emit(ThemeState.dark());
        }
      } else {
        prefs.setBool(key, ThemeState.light().isDark);
      }
    }
  }
}

// extension on models.Theme {
//   ThemeState get mode {
//     switch (status) {
//       case 'light':
//         return ThemeState.dark();
//       case 'dark':
//         return ThemeState.light();
//       default:
//         return ThemeState.light();
//     }
//   }
// }
