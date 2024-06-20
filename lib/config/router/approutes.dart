import 'package:venturelead/feathures/auth/view/view/login_auth.dart';
import 'package:venturelead/feathures/auth/view/view/register.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';
import 'package:venturelead/feathures/home/view/page/home.dart';
import 'package:venturelead/feathures/onboarding/view/page/onboarding_view.dart';
import 'package:venturelead/feathures/splash/view/page/splash.dart';

class AppRoute {
  AppRoute._();
  static const String authRoute = '/signin';
  static const String onboardRoute = '/onboard';
  static const String homeRoute = '/home';
  static const String splashRoute = '/splash';
  static const String dashboardRoute = '/dashboard';
  static const String signupRoute = '/signup';

  static getApplicationRoute() {
    return {
      authRoute: (context) => const LoginScreen(),
      onboardRoute: (context) => OnboardingScreen(),
      splashRoute: (context) => const SplashScreen(),
      homeRoute: (context) => HomeView(),
      dashboardRoute: (context) => const DashboardView(),
      signupRoute: (context) => const SignupView(),
    };
  }
}
