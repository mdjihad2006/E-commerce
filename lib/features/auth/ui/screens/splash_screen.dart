import 'package:bazario/app/app_config.dart';
import 'package:bazario/core/extensions/localizetions_extensions.dart';
import 'package:bazario/features/auth/controller/auth_controller.dart';
import 'package:bazario/features/auth/ui/screens/sign_in_screen.dart';
import 'package:bazario/features/auth/ui/widgets/app_logo.dart';
import 'package:bazario/features/common/ui/screens/main_bottom_navbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String name = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _movedToNextScreen();
  }

  Future<void> _movedToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      if(Get.find<AuthController>().isValidUser()){
        Get.offAll(MainBottomNavBarScreen(),transition: Transition.leftToRight,duration: Duration(seconds: 1));
      }
      else{
        Navigator.pushReplacementNamed(context, SignInScreen.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              appLogo(),
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Spacer(),
              Text("${context.localization.version} ${AppConfigs.currentAppVersion}")
            ],
          ),
        ),
      ),
    );
  }
}
