
import 'package:bazario/core/widgets/center_circular_progress_indicator.dart';
import 'package:bazario/features/categories/data/category_model/category_modal.dart';
import 'package:bazario/features/common/ui/widets/product_cart.dart';
import 'package:bazario/features/home/products/controllers/product_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, required this.category});

  final CategoryModel category;

  static const String name = '/products';

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductListController _productListController = ProductListController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _productListController.getProductListByCategory(widget.category.id);
    _scrollController.addListener(_loadData);
  }

  void _loadData() {
    if (_scrollController.position.extentAfter < 300) {
      _productListController.getProductListByCategory(widget.category.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
      ),
      body: GetBuilder(
          init: _productListController,
          builder: (controller) {
            if (controller.isInitialLoading) {
              return const CenterCircularProgressIndicator();
            }

            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: controller.productList.length,
                    controller: _scrollController,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 0),
                    itemBuilder: (context, index) {
                      return FittedBox(
                        child: ProductCard(
                          productModel: controller.productList[index],
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: controller.isLoading,
                  child: const LinearProgressIndicator(),
                )
              ],
            );
          }),
    );
  }
}