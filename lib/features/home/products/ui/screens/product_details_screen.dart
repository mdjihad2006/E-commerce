import 'package:bazario/features/common/ui/screens/main_bottom_navbar_screen.dart';
import 'package:bazario/features/home/products/ui/screens/reviews_screen.dart';
import 'package:flutter/material.dart';
import 'package:bazario/app/app_colors.dart';
import 'package:bazario/core/extensions/localizetions_extensions.dart';
import 'package:bazario/features/home/products/widgets/color_picker.dart';
import 'package:bazario/features/home/products/widgets/increment_decrement-counter.dart';
import 'package:bazario/features/home/products/widgets/size_picker.dart';
import 'package:bazario/features/home/ui/widgets/home_carosel_slider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});
  static const String name = "/product-details";

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back_ios)),
          title: Text(context.localization.productDetails)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: [
              const HomeCaroselSlider(),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Nike 320 2025 new edition",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber, size: 18),
                                  const SizedBox(width: 4),
                                  const Text("4.2"),
                                  TextButton(onPressed: () {
                                    Navigator.pushNamed(context, ReviewsScreen.name);
                                  }, child: const Text("Reviews")),
                                  Card(
                                    color: AppColors.themeColor,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(4),
                                      child: Icon(Icons.favorite_border, size: 16, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IncrementDecrementCounter(onchange: (val) => print(val)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ColorPicker(
                      Colors: ['Red', 'White', 'Black', 'Pink'],
                      onchange: (val) => print(val),
                    ),
                    const SizedBox(height: 16),
                    SizePicker(
                      Sizes: ['S', 'M', 'L', 'XL'],
                      onchange: (val) => print(val),
                    ),
                    const SizedBox(height: 24),
                    const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor, velit vel consectetur ultricies, "
                          "libero tellus pellentesque justo, vel efficitur felis neque sed neque. Sed sed massa vel neque "
                          "ullamcorper eleifend. Nullam vel quam non enim ultricies semper.",
                      style: TextStyle(height: 1.4),
                    ),
                  ],
                ),
              ),
              _priceAndCartSection(),
            ],
          ),
        ),
      ),
      //bottomNavigationBar: MainBottomNavbarScreen(),
    );
  }

  Widget _priceAndCartSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        color: AppColors.themeColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Price", style: TextStyle(fontSize: 14, color: Colors.white70)),
              SizedBox(height: 4),
              Text("\$1000", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          SizedBox(
            width: 140,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.themeColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
              child: const Text("Add to Cart"),
            ),
          ),
        ],
      ),
    );
  }
}
