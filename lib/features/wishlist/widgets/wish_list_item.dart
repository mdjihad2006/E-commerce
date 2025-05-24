import 'package:bazario/core/widgets/show_snackbar.dart';
import 'package:bazario/features/home/products/widgets/increment_decrement-counter.dart';
import 'package:bazario/features/wishlist/controller/get_wish_list_controller.dart';
import 'package:bazario/features/wishlist/data/model/wish_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListItem extends StatefulWidget {
  const WishListItem({
    super.key,
    required this.wishListItem,
  });

  final WishListModel wishListItem;

  @override
  State<WishListItem> createState() => _WishItemCardState();
}

class _WishItemCardState extends State<WishListItem> {
  bool _deleteInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 80,
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.wishListItem.productModel.photos.isNotEmpty
                      ? widget.wishListItem.productModel.photos[0]
                      : 'https://via.placeholder.com/100', // fallback
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return const Icon(Icons.error_outline);
                  },
                ),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.wishListItem.productModel.title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Text('Color: ${widget.wishListItem.color}  '),
                                SizedBox(width: 10),
                                Text('Size: ${widget.wishListItem.size}'),
                              ],
                            ),

                          ],
                        ),
                      ),
                      Visibility(
                        visible: _deleteInProgress == false,
                        replacement: const CircularProgressIndicator(),
                        child: IconButton(
                          onPressed: () async {
                            _deleteInProgress = true;
                            setState(() {});
                            final bool isSuccess =
                                await Get.find<GetWishListController>()
                                    .removeFromWIshList(context,widget.wishListItem.id);
                            _deleteInProgress = false;
                            setState(() {});
                            if (isSuccess == false) {
                              showSnackBarMessage(
                                  context,
                                  Get.find<GetWishListController>()
                                      .removeFromWishListErrorMessage!,
                                  true);
                            }
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${widget.wishListItem.productModel.currentPrice}'),
                      SizedBox(
                        width: 80,
                        child: FittedBox(
                          child: IncrementDecrementCounterWidget(
                            onChange: (int count) {
                              Get.find<GetWishListController>()
                                  .updateProduct(widget.wishListItem.id, count);
                            },
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}