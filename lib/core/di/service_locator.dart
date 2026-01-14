import 'package:get_it/get_it.dart';
import '../services/shared_preferences_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Initialize and register SharedPreferencesService
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferencesService>(
    SharedPreferencesService(sharedPreferences),
  );
}
