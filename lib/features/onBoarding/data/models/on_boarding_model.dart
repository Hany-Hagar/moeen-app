import 'package:flutter/widgets.dart';
import '../../../../generated/l10n.dart';

class OnBoardingData {
  final String image;
  final String title;
  final String description;

  OnBoardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnBoardingData> onBoardingData({required BuildContext context}) {
  var s = S.of(context);
  return [
    OnBoardingData(
      image: 'assets/lotties/wallet1.json',
      title: s.onBoardingTitle1,
      description: s.onBoardingSubTitle1,
    ),
    OnBoardingData(
      image: 'assets/lotties/wallet2.json',
      title: s.onBoardingTitle2,
      description: s.onBoardingSubTitle2,
    ),
    OnBoardingData(
      image: 'assets/lotties/wallet3.json',
      title: s.onBoardingTitle3,
      description: s.onBoardingSubTitle3,
    ),
  ];
}
