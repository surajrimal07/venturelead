import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/core/utils/shared_prefs.dart';
import 'package:venturelead/feathures/auth/controller/auth_network_controller.dart';
import 'package:venturelead/feathures/auth/view/view/login_auth.dart';
import 'package:venturelead/feathures/home/controller/network_controller.dart';
import 'package:venturelead/feathures/home/view/widget/navigation.dart';
import 'package:venturelead/feathures/onboarding/view/page/onboarding_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final userPrefs = UserSharedPrefss();

  void _handleNavigation() async {
    try {
      final isOnboardingSeen =
          await userPrefs.getData<bool>('isOnboardingSeen');
      final isOnboardingSeenValue = isOnboardingSeen ?? false;

      if (isOnboardingSeenValue) {
        final isLoginSaved = await userPrefs.getData<bool>('isLoggedInSave');
        final isLoginSavedValue = isLoginSaved ?? false;

        if (isLoginSavedValue) {
          final email = await userPrefs.getData<String>('email') ?? '';
          final password = await userPrefs.getData<String>('password') ?? '';

          bool isLoggedIn = await handleLoginController(email, password);
          if (isLoggedIn) {
            await fetchCompanies();
            await fetchAllCompanies();

            Get.off(() => const HomeView());
          } else {
            Get.off(() => const LoginScreen());
          }
        } else {
          Get.off(() => const LoginScreen());
        }
      } else {
        Get.off(() => OnboardingScreen());
      }
    } catch (e) {
      Get.off(() => const LoginScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    Future.delayed(const Duration(seconds: 2), () {
      _handleNavigation();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              height: 200,
            ),
            const SizedBox(height: 10),
            const Text(
              'For the Entrepreneur in You',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DotIndicator(isActive: _animation.value > 0.66),
                    DotIndicator(
                        isActive: _animation.value > 0.33 &&
                            _animation.value <= 0.66),
                    DotIndicator(isActive: _animation.value <= 0.33),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.red : Colors.red.withOpacity(0.5),
      ),
    );
  }
}
