import 'package:bazario/features/cart/ui/screens/controller/cart_list_controller.dart';
import 'package:bazario/features/cart/ui/screens/payment_screen.dart';
import 'package:bazario/features/cart/widget/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazario/app/app_colors.dart';
import 'package:bazario/core/widgets/center_circular_progress_indicator.dart';
import 'package:bazario/features/cart/data/model/cart_model.dart';
import 'package:bazario/features/common/controllers/mainbottom_navbar_controller.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  final CartListController _cartListController = Get.find<CartListController>();

  @override
  void initState() {
    super.initState();
    _cartListController.getCartList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (_, __) {
        Get.find<MainBottomNavBarController>().backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.find<MainBottomNavBarController>().backToHome();
            },
          ),
          title: const Text('Cart List'),
        ),
        body: GetBuilder<CartListController>(
          builder: (controller) {
            if (controller.getCartListInProgress) {
              return const CenterCircularProgressIndicator();
            }

            if (controller.cartItemList.isEmpty) {
              return const Center(child: Text("Your cart is empty."));
            }

            return Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: controller.cartItemList.length,
                      itemBuilder: (context, index) {
                        CartItemModel cartItem = controller.cartItemList[index];
                        return CartItemCard(cartItem: cartItem);
                      },
                    ),
                  ),
                ),
                _buildTotalPriceSection(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTotalPriceSection() {
    return GetBuilder<CartListController>(
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.themeColor.withOpacity(0.1),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Price'),
                  Text(
                    '৳${controller.totalPrice}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.themeColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 140,
                child: ElevatedButton(
                  onPressed: () {
                    PaymentMethodGetwayIntegration(context,controller.totalPrice.toDouble());
                   //Get.to(PaymentScreen(paymentAmount: controller.totalPrice.toDouble())); // Handle checkout
                  },
                  child: const Text('Checkout'),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
