import 'generated/l10n.dart';
import 'package:flutter/material.dart';
import 'core/di/service_locator.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/settings/cubits/settings_cubit.dart';
import 'core/settings/cubits/settings_states.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/splash/presentation/pages/views/splash_view.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await di.init();
  runApp(
    BlocProvider(
      create: (context) => di.getIt<SettingsCubit>(),
      child: const MyApp(),
    ),
  );
}

bool _isSplashRemoved = false;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (prev, curr) => curr is SettingsLoaded,
      builder: (context, state) {
        if (state is SettingsLoaded && !_isSplashRemoved) {
          Future.microtask(() {
            FlutterNativeSplash.remove();
            _isSplashRemoved = true;
          });
        }

        final settings = SettingsCubit.get(context).currentSettings;
        return ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              title: 'Moeen مُعِين',
              debugShowCheckedModeBanner: false,
              themeMode: settings.theme,
              locale: Locale(settings.language),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              home: const SplashView(),
            );
          },
        );
      },
    );
  }
}
