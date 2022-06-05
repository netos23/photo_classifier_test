import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'themes.dart' as themes;

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit._(ThemeData initialState) : super(initialState);

  factory ThemeCubit.light() => ThemeCubit._(themes.lightTheme);

  factory ThemeCubit.dark() => ThemeCubit._(themes.darkTheme);

  void toggle() => emit(
        state.brightness == Brightness.light
            ? themes.darkTheme
            : themes.lightTheme,
      );

  void setDark() => emit(themes.darkTheme);

  void setLight() => emit(themes.lightTheme);
}
