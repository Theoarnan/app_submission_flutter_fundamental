abstract class SettingState {
  const SettingState();
  List<Object?> get props => [];
}

class SettingInitialState extends SettingState {}

class SettingLoadingState extends SettingState {}

class SettingThemeSuccess extends SettingState {
  final bool isDarkTheme;
  SettingThemeSuccess({this.isDarkTheme = false});
  @override
  List<Object> get props => [isDarkTheme];
}

class SettingErrorState extends SettingState {
  final String error;
  SettingErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
