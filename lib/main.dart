import 'generated/l10n.dart';
import 'package:flutter/material.dart';
import 'core/utils/my_bloc_observer.dart';
import 'core/di/service_locator.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/settings/presentation/manager/settings_state.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'features/splash/presentation/pages/views/splash_view.dart';
import 'package:moeen_app/core/settings/presentation/manager/settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.getIt<SettingsCubit>()..fetchSettings(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                title: 'Flutter Demo',
                themeMode: state is SettingsLoaded
                    ? state.settings.theme
                    : ThemeMode.system,
                theme: ThemeData.light(),
                darkTheme: ThemeData.dark(),
                debugShowCheckedModeBanner: false,
                localizationsDelegates: [
                  S.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                locale: Locale(
                  state is SettingsLoaded ? state.settings.language : 'en',
                ),
                home: SplashView(),
              );
            },
          );
        },
      ),
    );
  }
}
