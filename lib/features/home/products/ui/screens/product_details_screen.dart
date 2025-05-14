
import 'package:bazario/app/app_colors.dart';
import 'package:bazario/core/extensions/localizetions_extensions.dart';
import 'package:bazario/core/widgets/center_circular_progress_indicator.dart';
import 'package:bazario/core/widgets/show_snackbar.dart';
import 'package:bazario/features/auth/controller/auth_controller.dart';
import 'package:bazario/features/auth/ui/screens/sign_in_screen.dart';
import 'package:bazario/features/auth/ui/widgets/snack_bar_message.dart';
import 'package:bazario/features/cart/ui/screens/cart_screens.dart';
import 'package:bazario/features/common/controllers/add_to_card-controller.dart';
import 'package:bazario/features/home/products/controllers/product_details_controller.dart';
import 'package:bazario/features/home/products/ui/screens/reviews_screen.dart';
import 'package:bazario/features/home/products/widgets/color_picker.dart';
import 'package:bazario/features/home/products/widgets/increment_decrement-counter.dart';
import 'package:bazario/features/home/products/widgets/product_carousel_slider.dart';
import 'package:bazario/features/home/products/widgets/size_picker.dart';
import 'package:bazario/features/wishlist/controller/add_to_wish_lsit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final String productId;

  static const String name = '/product-details';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsController _productDetailsController =
  ProductDetailsController();
  final AddToCartController _addToCartController = AddToCartController();
  final AddToWishListController _addToWishListController =AddToWishListController();

  String? _selectedColor;
  String? _selectedSize;

  @override
  void initState() {
    super.initState();
    _productDetailsController.getProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.localization.productDetails),
      ),
      body: GetBuilder(
        init: _productDetailsController,
        builder: (controller) {
          if (controller.inProgress) {
            return const CenterCircularProgressIndicator();
          }

          if (controller.errorMessage != null) {
            return Center(
              child: Text(controller.errorMessage!),
            );
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductImageCarouselSlider(
                        imageList: controller.product.photos,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.product.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 20,
                                              ),
                                              Text(
                                                '${controller.product.rating}',
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Get.to(
                                                  ReviewsScreen(),
                                                transition: Transition.downToUp,
                                                duration: Duration(seconds: 1)
                                              );
                                            },
                                            child: const Text('Reviews'),
                                          ),
                                          GetBuilder(
                                              init: _addToWishListController,
                                              builder: (controller) {
                                                return Visibility(
                                                  visible: controller.inProgress == false,
                                                  replacement: const CenterCircularProgressIndicator(),
                                                  child: IconButton(onPressed: ()async{
                                                    final bool isSuccess = await _addToWishListController.addToWishList(_productDetailsController.product.id);
                                                    if (isSuccess) {
                                                      showSnackBarMessage(context, 'Add to wishList');
                                                    } else {
                                                      showSnackBarMessage(context,
                                                          _addToWishListController.errorMessage!, true);
                                                    }
                                                  }, icon: Icon(Icons.favorite_border))
                                                );
                                              }),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                IncrementDecrementCounterWidget(
                                  onChange: (int value) {
                                    print(value);
                                  },
                                ),
                              ],
                            ),
                            if (controller.product.colors.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  ColorPicker(
                                    colors: controller.product.colors,
                                    onChange: (selectedColor) {
                                      _selectedColor = selectedColor;
                                    },
                                  ),
                                ],
                              ),
                            Visibility(
                              visible: controller.product.sizes.isNotEmpty,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  SizePicker(
                                    sizes: controller.product.sizes,
                                    onChange: (selectedSize) {
                                      _selectedSize = selectedSize;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              controller.product.description,
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _buildPriceAndAddToCartSection(
                  controller.product.sizes.isNotEmpty,
                  controller.product.colors.isNotEmpty),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPriceAndAddToCartSection(
      bool isSizeAvailable, bool isColorAvailable) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: AppColors.themeColor.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price'),
              Text(
                '\$1000',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.themeColor),
              ),
            ],
          ),
          SizedBox(
            width: 140,
            child: GetBuilder(
                init: _addToCartController,
                builder: (controller) {
                  return Visibility(
                    visible: controller.inProgress == false,
                    replacement: const CenterCircularProgressIndicator(),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (isSizeAvailable && _selectedSize == null) {
                          showSnackBarMessage(
                            context,
                            'Please select your size',
                            true,
                          );
                          return;
                        }
                        if (isColorAvailable && _selectedColor == null) {
                          showSnackBarMessage(
                              context, 'Please select your color', true);
                          return;
                        }

                        if (Get.find<AuthController>().isValidUser() == false) {
                          Get.to(() => const SignInScreen());
                          return;
                        }

                        final bool isSuccess = await _addToCartController
                            .addToCart(_productDetailsController.product.id);
                        if (isSuccess) {
                          GestureDetector(
                            child: Card(
                              child: Row(
                                children: [
                                  Text('add to cart successfully'),
                                  TextButton(onPressed: (){
                                    Get.to(CartListScreen);
                                  }, child: Text('go to cart'))

                                ],
                              ),
                            ),
                          );
                        } else {
                          showSnackBarMessage(context,
                              _addToCartController.errorMessage!, true);
                        }
                      },
                      child: const Text('Add to Cart'),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }



}