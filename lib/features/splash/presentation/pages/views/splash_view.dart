import '../widgets/splash_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/navigator_methods.dart';
import '../../../../../core/settings/presentation/manager/settings_cubit.dart';
import '../../../../../core/settings/presentation/manager/settings_state.dart';
import '../../../../onBoarding/presentation/pages/views/on_boarding_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsLoaded) {
          NavTo.pushReplacement(context: context, nextPage: OnBoardingView());
        }
      },

      child: Scaffold(
        body: Stack(children: const [_BackGound(), SplashBody()]),
      ),
    );
  }
}

class _BackGound extends StatelessWidget {
  const _BackGound();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/splash_background.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
