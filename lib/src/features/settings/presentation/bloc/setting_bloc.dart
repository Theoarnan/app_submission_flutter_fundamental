import 'dart:developer';

import 'package:app_submission_flutter_fundamental/src/common/utils/shared_preference_app.dart';
import 'package:app_submission_flutter_fundamental/src/features/settings/presentation/bloc/setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingBlocCubit extends Cubit<SettingState> {
  SettingBlocCubit() : super(SettingInitialState());

  final SharePreferencesAppImpl sharePreferencesAppImpl =
      SharePreferencesAppImpl();

  void getTheme() async {
    emit(SettingLoadingState());
    try {
      final isDarkTheme = await sharePreferencesAppImpl.getheme();
      emit(SettingThemeSuccess(isDarkTheme: isDarkTheme));
    } catch (e) {
      emit(SettingErrorState(error: e.toString()));
    }
  }

  void changeTheme({required bool isDark}) async {
    emit(SettingLoadingState());
    try {
      await sharePreferencesAppImpl.saveTheme(isDark);
      emit(SettingThemeSuccess(isDarkTheme: isDark));
    } catch (e) {
      emit(SettingErrorState(error: e.toString()));
    }
  }
}
