import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazario/core/widgets/center_circular_progress_indicator.dart';
import 'package:bazario/features/categories/data/category_model/category_modal.dart';
import 'package:bazario/features/common/ui/widets/product_cart.dart';
import 'package:bazario/features/home/products/controllers/product_list_controller.dart';

class ProductListScreen extends StatefulWidget {

  static final String name = '/product-list';

  const ProductListScreen({super.key, required this.category});
  final CategoryModel category;
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late final ProductListController _productListController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Initialize the controller using Get.put to allow GetBuilder to work
    _productListController = Get.put(ProductListController());
    _productListController.getProductListByCategory(widget.category.id);
    _scrollController.addListener(_loadData);
  }

  void _loadData() {
    if (_scrollController.position.extentAfter < 300) {
      _productListController.getProductListByCategory(widget.category.id);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadData);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
      ),
      body: GetBuilder<ProductListController>(
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 0,
                  ),
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
              ),
            ],
          );
        },
      ),
    );
  }
}
