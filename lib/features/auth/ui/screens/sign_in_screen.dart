import 'package:bazario/app/app_colors.dart';
import 'package:bazario/core/extensions/localizetions_extensions.dart';
import 'package:bazario/core/widgets/show_snackbar.dart';
import 'package:bazario/features/auth/data/modals/sign_in_modal.dart';
import 'package:bazario/features/auth/ui/controllers/sign_in_controller.dart';
import 'package:bazario/features/auth/ui/screens/sign_up_screen.dart';
import 'package:bazario/features/auth/ui/widgets/app_logo.dart';
import 'package:bazario/features/common/ui/screens/main_bottom_navbar_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final SignInController _signInController = Get.find<SignInController>();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme
        .of(context)
        .textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _key,
            child: Column(
              children: [
                const SizedBox(height: 60),
                const appLogo(),
                const SizedBox(height: 24),
                Text(
                  context.localization.welcomeBack,
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  context.localization.enterYourEmailAndPassword,
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailTEController,
                  decoration:
                  InputDecoration(hintText: context.localization.email),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordTEController,
                  obscureText: true,
                  decoration:
                  InputDecoration(hintText: context.localization.password),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onTapSignInButton,
                  child: Text(context.localization.signIn),
                ),
                const SizedBox(height: 24),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                          text: 'Sign up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.themeColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = _onTapSignUpButton
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _onTapSignInButton() async {
    SignInModal signInModel = SignInModal(
      email: _emailTEController.text.trim(),
      password: _passwordTEController.text,
    );
    final bool isSuccess = await _signInController.signIn(signInModel);
    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
          context, MainBottomNavbarScreen.name, (predicate) => false);
    } else {
      showSnackBarMessage(context, _signInController.errorMessage!, true);
    }
    // TODO: validate the form

  }

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}