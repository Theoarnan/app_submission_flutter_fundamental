abstract class SettingState {
  const SettingState();
  List<Object?> get props => [];
}

class SettingInitialState extends SettingState {}

class SettingLoadingState extends SettingState {}

class SettingSettingSuccess extends SettingState {
  final bool isDarkTheme;
  final bool isActivedNotif;
  SettingSettingSuccess({
    this.isDarkTheme = false,
    this.isActivedNotif = false,
  });
  @override
  List<Object> get props => [isDarkTheme, isActivedNotif];
}

class SettingErrorState extends SettingState {
  final String error;
  SettingErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
