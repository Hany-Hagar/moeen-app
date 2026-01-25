import '../../data/models/user_settings_model.dart';

abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final String? errMsg;
  final UserSettingsModel settings;
  final themes = ['Light', 'Dark', 'System'];
  final languages = ['English', 'Arabic'];
  SettingsLoaded({required this.settings, this.errMsg});
}
