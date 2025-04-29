import 'package:bazario/features/categories/ui/screens/category_list_screen.dart';
import 'package:bazario/features/common/controllers/mainbottom_navbar_controller.dart';
import 'package:bazario/features/common/controllers/sliders_controller.dart';
import 'package:bazario/features/home/ui/screen/home_screen.dart';
import 'package:bazario/features/wishlist/wish_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavbarScreen extends StatefulWidget {
  const MainBottomNavbarScreen({super.key});
  static const String name = '/main-bottom-navbar';

  @override
  State<MainBottomNavbarScreen> createState() => _MainBottomNavbarScreenState();
}

class _MainBottomNavbarScreenState extends State<MainBottomNavbarScreen> {
  final MainBottomVavBarController _bottomNavbarController = Get.find<MainBottomVavBarController>();

  final List<Widget> _screens = [
    const HomeScreen(),
    CategoryListScreen(),
    const HomeScreen(),
    const WishList(),
  ];
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.find<HomeSliderController> ().getSlider();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainBottomVavBarController>(
        builder: (controller) {
          return _screens.asMap().containsKey(controller.selectedIndex)
              ? _screens[controller.selectedIndex]
              : _screens[0];
        },
      ),
      bottomNavigationBar: GetBuilder<MainBottomVavBarController>(
        builder: (controller) {
          return NavigationBar(
            selectedIndex: controller.selectedIndex,
            onDestinationSelected: controller.changeIndex,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: "Home"),
              NavigationDestination(icon: Icon(Icons.category), label: "Category"),
              NavigationDestination(icon: Icon(Icons.shopping_cart), label: "Cart"),
              NavigationDestination(icon: Icon(Icons.favorite_border), label: "Wishlist"),
            ],
          );
        },
      ),
    );
  }
}
