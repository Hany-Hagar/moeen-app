import 'package:flutter/material.dart';

class UserSettingsModel {
  final ThemeMode theme;
  final String language;
  final bool notificationsEnabled;
  final bool isFirstTime;
  final bool isLoggedIn;

  UserSettingsModel({
    required this.theme,
    required this.language,
    required this.notificationsEnabled,
    required this.isFirstTime,
    required this.isLoggedIn,
  });

  UserSettingsModel copyWith({
    ThemeMode? theme,
    String? language,
    bool? notificationsEnabled,
    bool? isFirstTime,
    bool? isLoggedIn,
  }) {
    return UserSettingsModel(
      theme: theme ?? this.theme,
      language: language ?? this.language,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    );
  }

  factory UserSettingsModel.initial() {
    return UserSettingsModel(
      theme: ThemeMode.system,
      language: 'en',
      notificationsEnabled: true,
      isFirstTime: true,
      isLoggedIn: false,
    );
  }
}
