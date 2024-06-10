import 'package:venturelead/feathures/onboarding/view/widget/onboarding_widget.dart';

class OnboardingModel {
  final String title;
  final String subtitle;
  final String image;

  const OnboardingModel({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

final List<OnboardingModel> onBoardingData = [
  const OnboardingModel(
    title: 'Business Portal in a mobile',
    subtitle:
        "Never miss out what's happening in the business ecosystem, everyday",
    image: 'assets/images/logo.png',
  ),
  const OnboardingModel(
    title: 'Your Personal Business Space',
    subtitle:
        "Never miss out what's happening in the business ecosystem, everyday",
    image: 'assets/images/logo.png',
  ),
  const OnboardingModel(
    title: 'Title 3',
    subtitle:
        "Never miss out what's happening in the business ecosystem, everyday",
    image: 'assets/images/logo.png',
  ),
  const OnboardingModel(
    title: 'Title 4',
    subtitle:
        "Never miss out what's happening in the business ecosystem, everyday",
    image: 'assets/images/logo.png',
  )
];
