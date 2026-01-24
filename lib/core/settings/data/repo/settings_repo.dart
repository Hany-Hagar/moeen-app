import 'package:flutter/material.dart';
import '../models/user_settings_model.dart';

abstract class SettingsRepo {
  Future<UserSettingsModel> fetchUserSettings();
  Future<ThemeMode> changeTheme(String key);
  Future<String> changeLanguage(String key);
  Future<void> changeNotifications(bool isEnabled);
  Future<void> updateFirstTime(bool isFirstTime);
  Future<void> updateLoginState(bool isLoggedIn);
}
