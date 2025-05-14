import 'package:bazario/features/auth/ui/screens/sign_in_screen.dart';
import 'package:bazario/features/auth/ui/screens/sign_up_screen.dart';
import 'package:bazario/features/auth/ui/screens/splash_screen.dart';
import 'package:bazario/features/auth/ui/screens/verify_otp_screen.dart';
import 'package:bazario/features/categories/data/category_model/category_modal.dart';
import 'package:bazario/features/common/ui/screens/main_bottom_navbar_screen.dart';
import 'package:bazario/features/home/products/ui/screens/create_review.dart';
import 'package:bazario/features/home/products/ui/screens/product_details_screen.dart';
import 'package:bazario/features/home/products/ui/screens/product_list_screen.dart';
import 'package:bazario/features/home/products/ui/screens/reviews_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Widget route; // No 'late' keyword here

    if (settings.name == '/') {
      route = const SplashScreen(); // Handle the initial route
    } else if (settings.name == SplashScreen.name) {
      route = const SplashScreen();
    } else if (settings.name == SignInScreen.name) {
      route = const SignInScreen();
    } else if (settings.name == SignUpScreen.name) {
      route = const SignUpScreen();
    } else if (settings.name == VerifyOtpScreen.name) {
      String email = settings.arguments as String;
      route = VerifyOtpScreen(email: email);
    } else if (settings.name == MainBottomNavBarScreen.name) {
      route = const MainBottomNavBarScreen();
    } else if (settings.name == ReviewsScreen.name) {
      route = const ReviewsScreen();
    } else if (settings.name == CreateReview.name) {
      route = const CreateReview();
    } else if (settings.name == ProductListScreen.name) {
      final category = settings.arguments as CategoryModel;
      route = ProductListScreen(category: category);
    } else if (settings.name == ProductDetailsScreen.name) {
      String productId = settings.arguments as String;
      route = ProductDetailsScreen(productId: productId);
    } else {
      // Default fallback for any unmatched route
      route =  Scaffold(
        body: Center(child: Text('Route not found')),
      );
    }

    return MaterialPageRoute(
      builder: (context) => route,
    );
  }
}