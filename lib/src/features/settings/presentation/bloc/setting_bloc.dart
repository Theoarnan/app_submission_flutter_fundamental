import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:app_submission_flutter_fundamental/src/common/utils/background_services.dart';
import 'package:app_submission_flutter_fundamental/src/common/utils/shared_preference_app.dart';
import 'package:app_submission_flutter_fundamental/src/common/utils/utils.dart';
import 'package:app_submission_flutter_fundamental/src/features/settings/presentation/bloc/setting_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingBlocCubit extends Cubit<SettingState> {
  SettingBlocCubit() : super(SettingInitialState());

  void getSetting() async {
    emit(SettingLoadingState());
    try {
      final isDarkTheme = SharePreferencesApp.getThemeMode();
      final isActivedNotif = SharePreferencesApp.getAlarmValue();
      emit(SettingSettingSuccess(
        isDarkTheme: isDarkTheme,
        isActivedNotif: isActivedNotif,
      ));
    } catch (e) {
      emit(SettingErrorState(error: e.toString()));
    }
  }

  void changeTheme({required bool isDark}) async {
    emit(SettingLoadingState());
    try {
      SharePreferencesApp.saveTheme(isDark);
      emit(SettingSettingSuccess(isDarkTheme: isDark));
      getSetting();
    } catch (e) {
      emit(SettingErrorState(error: e.toString()));
    }
  }

  void changeRestaurantNotif({required bool isSaveNotif}) async {
    emit(SettingLoadingState());
    SharePreferencesApp.saveAlarm(isSaveNotif);
    if (isSaveNotif) {
      await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: Utils.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      await AndroidAlarmManager.cancel(1);
    }
    emit(SettingSettingSuccess(isActivedNotif: isSaveNotif));
    getSetting();
  }

  void logoutApp() async {
    emit(SettingLoadingState());
    changeTheme(isDark: false);
    changeRestaurantNotif(isSaveNotif: false);
    emit(SettingSettingSuccess());
  }
}
