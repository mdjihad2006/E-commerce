import 'package:bazario/app/assets_path.dart';
import 'package:bazario/core/extensions/localizetions_extensions.dart';
import 'package:bazario/core/widgets/center_circular_progress_indicator.dart';
import 'package:bazario/features/categories/controller/category_controller.dart';
import 'package:bazario/features/categories/data/category_model/category_modal.dart';
import 'package:bazario/features/common/controllers/mainbottom_navbar_controller.dart';
import 'package:bazario/features/common/data/product_model.dart';
import 'package:bazario/features/common/ui/widets/category_item.dart';
import 'package:bazario/features/common/ui/widets/product_cart.dart';
import 'package:bazario/features/home/products/controllers/product_list_controller.dart';
import 'package:bazario/features/home/ui/widgets/app_bar_action_button.dart';
import 'package:bazario/features/home/ui/widgets/home_carosel_slider.dart';
import 'package:bazario/features/home/ui/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String name = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  final ProductListController _controller = Get.put(ProductListController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.getPopularProducts();
    _controller.getSpecialProducts();
    _controller.getNewProducts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSearchTextField(),
            const SizedBox(height: 16),
            const HomeCaroselSlider(),
            const SizedBox(height: 16),
            CategoryTItle(
              title: context.localization.categories,
              onTap: () {
                Get.find<MainBottomNavBarController>().moveToCategory();
              },
            ),
            const SizedBox(height: 16),
            _buildCategoriesSection(),
            const SizedBox(height: 16),
            CategoryTItle(
              title: context.localization.popular,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            _buildPopularCategoriesSection()  ,
            const SizedBox(height: 16),

            CategoryTItle(
              title: context.localization.special,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            _buildSpecialCategoriesSection(),
            const SizedBox(height: 16),

            CategoryTItle(
              title: context.localization.snew,
              onTap: () {},
            ),
            const SizedBox(height: 16),
            _buildNewCategoriesSection()
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        if (controller.isInitialLoading) {
          return const SizedBox(
            height: 100,
            child: CenterCircularProgressIndicator(),
          );
        }

        List<CategoryModel> list = controller.categoryList.length > 10
            ? controller.categoryList.sublist(0, 10)
            : controller.categoryList;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: list.map((e) {
              return CategoryItem(categoryModel: e);
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildPopularCategoriesSection() {
    return GetBuilder<ProductListController>(
      builder: (controller) {
        if (controller.isInitialLoading) {
          return const SizedBox(
            height: 100,
            child: CenterCircularProgressIndicator(),
          );
        }

        List<ProductModel> list = controller.productList.length > 10
            ? controller.productList.sublist(0, 10)
            : controller.productList;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: list.map((e) {
              return ProductCard(productModel: e);
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildSpecialCategoriesSection() {
    return GetBuilder<ProductListController>(
      builder: (controller) {
        if (controller.isInitialLoading) {
          return const SizedBox(
            height: 100,
            child: CenterCircularProgressIndicator(),
          );
        }

        List<ProductModel> list = controller.productList.length > 10
            ? controller.productList.sublist(0, 10)
            : controller.productList;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: list.map((e) {
              return ProductCard(productModel: e);
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildNewCategoriesSection() {
    return GetBuilder<ProductListController>(
      builder: (controller) {
        if (controller.isInitialLoading) {
          return const SizedBox(
            height: 100,
            child: CenterCircularProgressIndicator(),
          );
        }

        List<ProductModel> list = controller.productList.length > 10
            ? controller.productList.sublist(0, 10)
            : controller.productList;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: list.map((e) {
              return ProductCard(productModel: e);
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildSearchTextField() {
    return TextField(
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: SvgPicture.asset(AssetsPath.logoSvg),
      actions: [
        AppBarActionButton(icon: Icons.person_outline, onTap: () {}),
        const SizedBox(width: 8),
        AppBarActionButton(icon: Icons.call, onTap: () {}),
        const SizedBox(width: 8),
        AppBarActionButton(
          icon: Icons.logout,
          onTap: () async {
            bool? confirm = await Get.dialog(
              AlertDialog(
                title: const Text('Confirm Logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(result: false),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Get.back(result: true),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
            if (confirm ?? false) {
              // Perform logout logic
            }
          },
        ),
      ],
    );
  }
}
