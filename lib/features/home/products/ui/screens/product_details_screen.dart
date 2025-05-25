
import 'package:bazario/app/app_colors.dart';
import 'package:bazario/core/extensions/localizetions_extensions.dart';
import 'package:bazario/core/widgets/center_circular_progress_indicator.dart';
import 'package:bazario/core/widgets/show_snackbar.dart';
import 'package:bazario/features/auth/controller/auth_controller.dart';
import 'package:bazario/features/auth/ui/screens/sign_in_screen.dart';
import 'package:bazario/features/auth/ui/widgets/snack_bar_message.dart';
import 'package:bazario/features/cart/ui/screens/cart_screens.dart';
import 'package:bazario/features/common/controllers/add_to_card-controller.dart';
import 'package:bazario/features/common/data/product_model.dart';
import 'package:bazario/features/home/products/controllers/product_details_controller.dart';
import 'package:bazario/features/home/products/ui/screens/reviews_screen.dart';
import 'package:bazario/features/home/products/widgets/color_picker.dart';
import 'package:bazario/features/home/products/widgets/increment_decrement-counter.dart';
import 'package:bazario/features/home/products/widgets/product_carousel_slider.dart';
import 'package:bazario/features/home/products/widgets/size_picker.dart';
import 'package:bazario/features/wishlist/controller/add_to_wish_list.dart';
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
                                                ReviewsScreen(productId: controller.product.id),
                                                transition: Transition.downToUp,
                                                duration: const Duration(seconds: 1),
                                              );
                                            },



                                            child: const Text('Reviews'),
                                          ),
                                          GetBuilder<AddToWishListController>(
                                            init: _addToWishListController,
                                            builder: (controller) {
                                              final isFav = controller.isFavorite(_productDetailsController.product.id);

                                              return Visibility(
                                                visible: !controller.inProgress,
                                                replacement: const CenterCircularProgressIndicator(),
                                                child: IconButton(
                                                  onPressed: () async {
                                                    final isSuccess = await controller.addToWishList(
                                                        _productDetailsController.product.id);
                                                    if (isSuccess) {
                                                      showSnackBarMessage(context,
                                                          isFav ? 'Removed from wishlist' : 'Added to wishlist');
                                                    } else {
                                                      showSnackBarMessage(context,
                                                          controller.errorMessage ?? 'Something went wrong', true);
                                                    }
                                                  },
                                                  icon: Icon(
                                                    isFav ? Icons.favorite : Icons.favorite_border,
                                                    color: isFav ? Colors.red : Colors.grey,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Price'),
              Row(
                children: [
                  if (_productDetailsController.product.regularPrice >
                      _productDetailsController.product.currentPrice)
                     Text(
                      '৳${_productDetailsController.product.regularPrice}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const SizedBox(width: 8),
                   Text(
                    '৳${_productDetailsController.product.currentPrice}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.themeColor,
                    ),
                  ),
                ],
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
                          showSnackBarMessage(context, 'Successfully added');
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