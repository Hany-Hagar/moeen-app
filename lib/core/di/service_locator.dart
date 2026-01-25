import 'package:get_it/get_it.dart';
import '../settings/data/repo/settings_repo.dart';
import '../settings/data/repo/settings_repo_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../settings/presentation/manager/settings_cubit.dart';
import '../settings/data/database/shared_preferences_services.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Initialize and register SharedPreferencesService
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferencesService>(
    SharedPreferencesService(sharedPreferences),
  );
  getIt.registerSingleton<SettingsRepo>(
    SettingsRepoImpl(getIt<SharedPreferencesService>()),
  );

  getIt.registerLazySingleton<SettingsCubit>(
    () => SettingsCubit(getIt<SettingsRepo>()),
  );
}
