import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks/src/ui/helpers/helpers.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  // ignore: prefer_final_fields
  var _prefs = SharedPreferences.getInstance();

  ThemeCubit() : super(ThemeState.light()) {
    onChangeTheme();
  }

  void onChangeTheme() async {
    var prefs = await _prefs;
    var key = 'isDark';

    if (prefs.containsKey(key)) {
      var prefMode = prefs.getBool(key)!;

      if (prefMode) {
        emit(ThemeState.light());
      } else {
        emit(ThemeState.dark());
      }
    } else {
      emit(ThemeState.light());
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
