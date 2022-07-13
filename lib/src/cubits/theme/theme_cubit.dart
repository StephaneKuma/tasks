import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/ui/helpers/helpers.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.light());

  void onChangeTheme({required ThemeStatus status}) {
    emit(
      status == ThemeStatus.light
          ? ThemeState.light()
          : ThemeState.dark(),
    );
  }
}
