import 'package:bazario/features/auth/ui/screens/sign_in_screen.dart';
import 'package:bazario/features/auth/ui/screens/sign_up_screen.dart';
import 'package:bazario/features/auth/ui/screens/splash_screen.dart';
import 'package:bazario/features/auth/ui/screens/verify_otp_screen.dart';
import 'package:bazario/features/common/ui/screens/main_bottom_navbar_screen.dart';
import 'package:bazario/features/home/products/ui/screens/create_review.dart';
import 'package:bazario/features/home/products/ui/screens/product_details_screen.dart';
import 'package:bazario/features/home/products/ui/screens/product_list_screen.dart';
import 'package:bazario/features/home/products/ui/screens/reviews_screen.dart';
import 'package:bazario/features/home/ui/screen/home_screen.dart';
import 'package:flutter/Material.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    late Widget route;
    if (setting.name == SplashScreen.name) {
      route = const SplashScreen();
    } else if (setting.name == SignInScreen.name) {
      route = SignInScreen();
    } else if (setting.name == SignUpScreen.name) {
      route = const SignUpScreen();
    } else if (setting.name == VerifyOtpScreen.name) {
      final String email = setting.arguments as String;
      route = VerifyOtpScreen(email: email);
    }
    else if (setting.name == MainBottomNavbarScreen.name) {
      route = const MainBottomNavbarScreen();
    } else if (setting.name == HomeScreen.name) {
      route = HomeScreen();
    }
    else if (setting.name == ProductListScreen.name) {
      final String category = setting.arguments as String;
      route = ProductListScreen(category);
    }else if (setting.name == ProductDetailsScreen.name) {
      route = ProductDetailsScreen();
    }
    else if (setting.name == ReviewsScreen.name) {
      route = ReviewsScreen();
    }
    else if (setting.name == CreateReview.name) {
      route = CreateReview();
    }
    return MaterialPageRoute(
      builder: (context) {
        return route;
      },
    );
  }
}
