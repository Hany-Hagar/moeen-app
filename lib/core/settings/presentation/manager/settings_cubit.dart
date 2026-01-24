import 'settings_state.dart';
import '../../data/repo/settings_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_settings_model.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepo settingsRepo;
  SettingsCubit(this.settingsRepo) : super(SettingsInitial());

  void fetchSettings() async {
    emit(SettingsLoading());
    await settingsRepo
        .fetchUserSettings()
        .then((settings) {
          emit(SettingsLoaded(settings: settings));
        })
        .catchError((error) {
          emit(
            SettingsLoaded(
              settings: UserSettingsModel.initial(),
              errMsg: error.toString(),
            ),
          );
        });
  }

  void setThemeMode(String mode) async {
    await settingsRepo
        .changeTheme(mode)
        .then((newTheme) {
          var newSettings = (state as SettingsLoaded).settings.copyWith(
            theme: newTheme,
          );
          emit(SettingsLoaded(settings: newSettings));
        })
        .catchError((error) {
          emit(
            SettingsLoaded(
              settings: (state as SettingsLoaded).settings,
              errMsg: error.toString(),
            ),
          );
        });
  }

  void setLanguage(String language) async {
    await settingsRepo
        .changeLanguage(language)
        .then((newLanguage) {
          var newSettings = (state as SettingsLoaded).settings.copyWith(
            language: newLanguage,
          );
          emit(SettingsLoaded(settings: newSettings));
        })
        .catchError((error) {
          emit(
            SettingsLoaded(
              settings: (state as SettingsLoaded).settings,
              errMsg: error.toString(),
            ),
          );
        });
  }

  void setNotificationsEnabled(bool isEnabled) async {
    await settingsRepo
        .changeNotifications(isEnabled)
        .then((newValue) {
          var newSettings = (state as SettingsLoaded).settings.copyWith(
            notificationsEnabled: isEnabled,
          );
          emit(SettingsLoaded(settings: newSettings));
        })
        .catchError((error) {
          emit(
            SettingsLoaded(
              settings: (state as SettingsLoaded).settings,
              errMsg: error.toString(),
            ),
          );
        });
  }

  void setIsFirstTime(bool isFirstTime) async {
    await settingsRepo
        .updateFirstTime(isFirstTime)
        .then((newValue) {
          var newSettings = (state as SettingsLoaded).settings.copyWith(
            isFirstTime: isFirstTime,
          );
          emit(SettingsLoaded(settings: newSettings));
        })
        .catchError((error) {
          emit(
            SettingsLoaded(
              settings: (state as SettingsLoaded).settings,
              errMsg: error.toString(),
            ),
          );
        });
  }

  void setIsLoggedIn(bool isLoggedIn) async {
    await settingsRepo
        .updateLoginState(isLoggedIn)
        .then((newValue) {
          var newSettings = (state as SettingsLoaded).settings.copyWith(
            isLoggedIn: isLoggedIn,
          );
          emit(SettingsLoaded(settings: newSettings));
        })
        .catchError((error) {
          emit(
            SettingsLoaded(
              settings: (state as SettingsLoaded).settings,
              errMsg: error.toString(),
            ),
          );
        });
  }
}
