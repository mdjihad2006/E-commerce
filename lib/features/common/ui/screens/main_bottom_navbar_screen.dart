import 'package:bazario/features/auth/ui/screens/sign_in_screen.dart';
import 'package:bazario/features/cart/ui/screens/cart_screens.dart';
import 'package:bazario/features/categories/controller/category_controller.dart';
import 'package:bazario/features/categories/controller/get_category_by_slug.dart';
import 'package:bazario/features/categories/ui/screens/category_list_screen.dart';
import 'package:bazario/features/common/controllers/mainbottom_navbar_controller.dart';
import 'package:bazario/features/common/controllers/sliders_controller.dart';
import 'package:bazario/features/home/ui/screen/home_screen.dart';
import 'package:bazario/features/wishlist/wish_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  static const String name = '/main-nav-bar-screen';

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoryListScreen(),
    CartListScreen(),
    const WishListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<HomeSliderController>().getSlider();
      Get.find<CategoryController>().getCategoryList();
      //Get.find<CategoryByIdController>().getCategoryListById('67c29b221edf70fa6198fce5');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainBottomNavBarController>(
        builder: (controller) {
          return _screens[controller.selectedIndex];
        },
      ),
      bottomNavigationBar: GetBuilder<MainBottomNavBarController>(
        builder: (controller) {
          return NavigationBar(
            selectedIndex: controller.selectedIndex,
            onDestinationSelected: (int index) {
              if (controller.shouldNavigate(index)) {
                controller.changeIndex(index);
              } else {
                Get.to(() => const SignInScreen());
              }
            },
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.category), label: 'Category'),
              NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Cart'),
              NavigationDestination(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
            ],
          );
        },
      ),
    );
  }
}
