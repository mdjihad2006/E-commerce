// cart_item_card.dart

import 'package:bazario/core/widgets/show_snackbar.dart';
import 'package:bazario/features/cart/data/model/cart_model.dart';
import 'package:bazario/features/cart/ui/screens/controller/cart_list_controller.dart';
import 'package:bazario/features/home/products/widgets/increment_decrement-counter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemCard extends StatefulWidget {
  const CartItemCard({
    super.key,
    required this.cartItem,
  });

  final CartItemModel cartItem;

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
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
                  widget.cartItem.productModel.photos.isNotEmpty
                      ? widget.cartItem.productModel.photos[0]
                      : 'https://via.placeholder.com/100',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.cartItem.productModel.title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: [
                                Text('Color: ${widget.cartItem.color}   '),
                                Text('Size: ${widget.cartItem.size}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !_deleteInProgress,
                        replacement: const CircularProgressIndicator(),
                        child: IconButton(
                          onPressed: () async {
                            setState(() => _deleteInProgress = true);
                            final bool isSuccess =
                            await Get.find<CartListController>()
                                .removeFromCart(widget.cartItem.id);
                            setState(() => _deleteInProgress = false);

                            if (!isSuccess) {
                              showSnackBarMessage(
                                context,
                                Get.find<CartListController>()
                                    .removeFromCartErrorMessage ??
                                    'Error removing item',
                                true,
                              );
                            }
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${widget.cartItem.productModel.currentPrice}'),
                      SizedBox(
                        width: 80,
                        child: FittedBox(
                          child: IncrementDecrementCounterWidget(
                            onChange: (int count) {
                              Get.find<CartListController>()
                                  .updateProduct(widget.cartItem.id, count);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
