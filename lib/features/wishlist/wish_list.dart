import 'package:bazario/features/wishlist/controller/get_wish_list_controller.dart';
import 'package:bazario/features/wishlist/widgets/wish_list_item.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazario/core/widgets/center_circular_progress_indicator.dart';

import 'package:bazario/features/common/controllers/mainbottom_navbar_controller.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  late final GetWishListController _getWishListController;

  @override
  void initState() {
    super.initState();
    // Ensure controller is available
    _getWishListController = Get.find<GetWishListController>();
    // Fetch cart data
    _getWishListController.getWishList();
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
          title: const Text('WishList'),
        ),
        body: GetBuilder<GetWishListController>(
          builder: (controller) {
            if (controller.getCartListInProgress) {
              return const CenterCircularProgressIndicator();
            }

            if (controller.WishItemList.isEmpty) {
              return const Center(child: Text('Your wishlist is empty.'));
            }

            return ListView.builder(
              itemCount: controller.WishItemList.length,
              itemBuilder: (context, index) {
                final item = controller.WishItemList[index];
                return WishListItem(wishListItem: item);
              },
            );
          },
        ),

      ),
    );
  }


}
