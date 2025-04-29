import 'package:bazario/app/app_colors.dart';
import 'package:bazario/features/home/products/ui/screens/product_details_screen.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
     this.title,
     this.price,
     this.imageUrl,
  });

  final String? title;
  final int? price;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.name);
      },
      child: Card(
        child: SizedBox(
          width: 140,
          child: Column(
            children: [
              Container(
                height: 120,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                  color: AppColors.themeColor.withOpacity(0.15),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl!), // ✅ Use dynamic image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      title!,
                      maxLines: 1,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '৳ $price', // ✅ Use dynamic price
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.themeColor,
                          ),
                        ),
                        const Wrap(
                          children: [
                            Icon(Icons.star, size: 18, color: Colors.orange),
                            Text("3.3"),
                          ],
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          color: AppColors.themeColor,
                          child: const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Icon(Icons.favorite_border, size: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
