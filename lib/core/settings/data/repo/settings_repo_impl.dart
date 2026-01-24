import 'settings_repo.dart';
import 'package:flutter/material.dart';
import '../models/user_settings_model.dart';
import '../database/shared_preferences_services.dart';

class SettingsRepoImpl extends SettingsRepo {
  final SharedPreferencesService _localStorage;
  SettingsRepoImpl(this._localStorage);

  final String _isFirstTimeKey = 'is_first_time';
  static const Map<String, ThemeMode> themes = {
    'System': ThemeMode.system,
    'Light': ThemeMode.light,
    'Dark': ThemeMode.dark,
  };
  static const Map<String, String> languages = {
    'English': 'en',
    'Arabic': 'ar',
  };

  @override
  Future<UserSettingsModel> fetchUserSettings() async {
    try {
      var isFirstTime = _localStorage.getBool(
        _isFirstTimeKey,
        defaultValue: true,
      );
      if (isFirstTime) {
        await _localStorage.setBool(_isFirstTimeKey, false);
        return UserSettingsModel.initial();
      } else {
        return UserSettingsModel(
          language: _localStorage.getString('language', defaultValue: 'en'),
          theme:
              themes[_localStorage.getString('theme', defaultValue: 'Light')] ??
              ThemeMode.light,
          notificationsEnabled: _localStorage.getBool(
            'notifications_enabled',
            defaultValue: true,
          ),
          isFirstTime: isFirstTime,
          isLoggedIn: _localStorage.getBool(
            'is_logged_in',
            defaultValue: false,
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> changeLanguage(String key) async {
    try {
      await _localStorage.setString('language', languages[key] ?? 'en');
      return languages[key] ?? 'en';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> changeNotifications(bool isEnabled) async {
    try {
      await _localStorage.setBool('notifications_enabled', isEnabled);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ThemeMode> changeTheme(String key) async {
    try {
      await _localStorage.setString('theme', key);
      return themes[key] ?? ThemeMode.light;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateFirstTime(bool isFirstTime) async {
    try {
      await _localStorage.setBool(_isFirstTimeKey, isFirstTime);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateLoginState(bool isLoggedIn) {
    try {
      return _localStorage.setBool('is_logged_in', isLoggedIn);
    } catch (e) {
      rethrow;
    }
  }
}
