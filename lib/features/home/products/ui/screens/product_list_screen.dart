import 'package:bazario/features/common/ui/widets/product_cart.dart';
import 'package:flutter/Material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen(this.category, {super.key});
  final String category;

  static const String name = "/product-list";

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: 30,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 0,
            mainAxisSpacing: 8
          ),
          itemBuilder: (context,index) {
            return FittedBox(child: ProductCard());
          },
        ),
      ),
    );
  }
}
