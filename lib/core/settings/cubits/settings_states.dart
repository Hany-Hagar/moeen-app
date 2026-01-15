import '../models/user_settings_model.dart';

sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsLoaded extends SettingsState {
  final String? errorMessage; // رسالة خطأ مؤقتة
  final UserSettingsModel settings;
  SettingsLoaded({required this.settings, this.errorMessage});
}
