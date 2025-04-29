import 'package:bazario/app/app_colors.dart';
import 'package:bazario/app/assets_path.dart';
import 'package:bazario/core/extensions/localizetions_extensions.dart';
import 'package:bazario/features/common/controllers/mainbottom_navbar_controller.dart';
import 'package:bazario/features/common/ui/widets/category_item.dart';
import 'package:bazario/features/common/ui/widets/product_cart.dart';
import 'package:bazario/features/home/ui/widgets/app_bar_action_button.dart';
import 'package:bazario/features/home/ui/widgets/home_carosel_slider.dart';
import 'package:bazario/features/home/ui/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String name = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildSearchTextField(),
              SizedBox(height: 16),
              HomeCaroselSlider(),
              SizedBox(height: 16),
              CategoryTItle(title: context.localization.categories, onTap: () {
                Get.find<MainBottomVavBarController>().moveToCategory();
              }),
              SizedBox(height: 12),
              CategoryItem(),
              const SizedBox(height: 16),
              CategoryTItle(title: context.localization.popular, onTap: () {}),
              const SizedBox(height: 16),
              CategoryItem(),
              SizedBox(height: 16),
              CategoryTItle(title: context.localization.special, onTap: () {}),
              CategoryItem(),              SizedBox(height: 16),
              CategoryTItle(title: context.localization.snew, onTap: () {}),
              CategoryItem(),            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
        ],
      ),
    );
  }


  TextField _buildSearchTextField() {
    return TextField(
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: "search",
        prefixIcon: Icon(Icons.search),

        border: OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.themeColor,
      leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios,size: 18,)),
      title: SvgPicture.asset(AssetsPath.appbarlogoPng, height: 60, width: 60),
      actions: [
        AppBarActionButton(icon: (Icons.padding_outlined), onTap: () {}),
        SizedBox(width: 8),
        AppBarActionButton(icon: (Icons.call), onTap: () {}),
        SizedBox(width: 8),
        AppBarActionButton(icon: (Icons.notifications), onTap: () {}),
      ],
    );
  }
}
