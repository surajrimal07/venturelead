import 'package:venturelead/feathures/auth/view/view/login.dart';
import 'package:venturelead/feathures/home/view/page/navigation.dart';
import 'package:venturelead/feathures/home/view/widget/home.dart';
import 'package:venturelead/feathures/onboarding/view/page/onboarding_view.dart';
import 'package:venturelead/feathures/splash/view/page/splash.dart';

class AppRoute {
  AppRoute._();
  static const String authRoute = '/signin';
  static const String onboardRoute = '/onboard';
  static const String homeRoute = '/home';
  static const String splashRoute = '/splash';
  static const String dashboardRoute = '/dashboard';

  static getApplicationRoute() {
    return {
      authRoute: (context) => const EmailLoginPage(),
      onboardRoute: (context) => const OnboardingScreen(),
      splashRoute: (context) => const SplashScreen(),
      homeRoute: (context) => HomeView(),
      dashboardRoute: (context) => const DashboardView(),
    };
  }
}
