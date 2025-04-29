import 'package:bazario/core/extensions/localizetions_extensions.dart';
import 'package:bazario/features/common/ui/widets/product_cart.dart';
import 'package:bazario/features/wishlist/data/wish_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  static const String name = "/wish-list";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.localization.wishlist)),
      body: GetBuilder<WishListController>(
        init: WishListController()..fetchWishlist(),
        builder: (controller) {
          if (controller.inProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!));
          }

          if (controller.wishlist.isEmpty) {
            return Center(child: Text('No item here'));
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              itemCount: controller.wishlist.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 0,
                mainAxisSpacing: 8,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final item = controller?.wishlist[index];
                return FittedBox(
                  child: ProductCard(
                    title: item?.title,
                    price: item?.price.toInt(),
                    imageUrl: item?.image,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
