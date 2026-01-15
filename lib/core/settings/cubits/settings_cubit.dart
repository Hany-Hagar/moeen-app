import 'settings_states.dart';
import 'package:flutter/material.dart';
import '../models/user_settings_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SharedPreferences _data;
  SettingsCubit(this._data) : super(SettingsInitial()) {
    getUserSettings();
  }
  static SettingsCubit get(BuildContext context) =>
      BlocProvider.of<SettingsCubit>(context);

  /// Data
  UserSettingsModel get currentSettings {
    if (state is SettingsLoaded) {
      return (state as SettingsLoaded).settings;
    }
    return UserSettingsModel.initial();
  }

  static const Map<String, ThemeMode> themes = {
    'System': ThemeMode.system,
    'Light': ThemeMode.light,
    'Dark': ThemeMode.dark,
  };
  static const Map<String, String> languages = {
    'English': 'en',
    'Arabic': 'ar',
  };

  // Get User Settings

  void getUserSettings() {
    emit(SettingsLoading());
    try {
      final model = UserSettingsModel(
        theme: themes[_data.getString('theme') ?? 'System'] ?? ThemeMode.system,
        language: _data.getString('language') ?? 'en',
        notificationsEnabled: _data.getBool('notifications') ?? true,
        isFirstTime: _data.getBool('isFirstTime') ?? true,
        isLoggedIn: _data.getBool('isLoggedIn') ?? false,
      );
      emit(SettingsLoaded(settings: model));
    } catch (e) {
      emit(
        SettingsLoaded(
          settings: UserSettingsModel.initial(),
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> updateSettings({
    String? themeKey,
    ThemeMode? theme,
    String? languageKey,
    String? language,
    bool? notificationsEnabled,
    bool? isFirstTime,
    bool? isLoggedIn,
  }) async {
    final oldSettings = currentSettings;

    final updatedModel = _updateSettingsModel(
      theme: theme,
      language: language,
      notificationsEnabled: notificationsEnabled,
      isFirstTime: isFirstTime,
      isLoggedIn: isLoggedIn,
    );

    emit(SettingsLoaded(settings: updatedModel));
    try {
      await _updateSettingsSharedPreferences(
        themeKey: themeKey,
        languageKey: languageKey,
        notificationsEnabled: notificationsEnabled,
        isFirstTime: isFirstTime,
        isLoggedIn: isLoggedIn,
      );
    } catch (e) {
      emit(SettingsLoaded(settings: oldSettings, errorMessage: e.toString()));
    }
  }

  UserSettingsModel _updateSettingsModel({
    ThemeMode? theme,
    String? language,
    bool? notificationsEnabled,
    bool? isFirstTime,
    bool? isLoggedIn,
  }) {
    return currentSettings.copyWith(
      theme: theme,
      language: language,
      notificationsEnabled: notificationsEnabled,
      isFirstTime: isFirstTime,
      isLoggedIn: isLoggedIn,
    );
  }

  Future<void> _updateSettingsSharedPreferences({
    String? themeKey,
    String? languageKey,
    bool? notificationsEnabled,
    bool? isFirstTime,
    bool? isLoggedIn,
  }) async {
    if (themeKey != null) {
      await _data.setString('theme', themeKey);
    }
    if (languageKey != null) {
      await _data.setString('language', languageKey);
    }
    if (notificationsEnabled != null) {
      await _data.setBool('notifications', notificationsEnabled);
    }
    if (isFirstTime != null) {
      await _data.setBool('isFirstTime', isFirstTime);
    }
    if (isLoggedIn != null) {
      await _data.setBool('isLoggedIn', isLoggedIn);
    }
  }

  // Change Theme
  Future<void> changeTheme(String key) async =>
      await updateSettings(themeKey: key, theme: themes[key]);

  // Change Language
  Future<void> changeLanguage(String key) async =>
      await updateSettings(languageKey: key, language: languages[key]);

  // Change Notifications
  Future<void> changeNotifications(bool isEnabled) async =>
      await updateSettings(notificationsEnabled: isEnabled);

  // Update First Time
  Future<void> updateFirstTime(bool isFirstTime) async =>
      await updateSettings(isFirstTime: isFirstTime);

  // Update Login State
  Future<void> updateLoginState(bool isLoggedIn) async =>
      await updateSettings(isLoggedIn: isLoggedIn);
}
