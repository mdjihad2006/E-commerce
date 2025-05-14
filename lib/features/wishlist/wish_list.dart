import 'package:bazario/features/wishlist/controller/get_wish_list_controller.dart';
import 'package:bazario/features/wishlist/data/model/wish_list_model.dart';
import 'package:bazario/features/wishlist/widgets/wishListItem.dart';
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
    _getWishListController = Get.put(GetWishListController());

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
            if (controller.getWishListListInProgress) {
              return const CenterCircularProgressIndicator();
            }

            return Column(
              children: [
                // Cart Items List
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: controller.WishLIstItemList.length,
                      itemBuilder: (context, index) {
                        WishListModel wishListItem = controller.WishLIstItemList[index];
                        return WishListItem(wishListModel: wishListItem);
                      },
                    ),
                  ),
                ),

                // Total Price Section

              ],
            );
          },
        ),
      ),
    );
  }


}
