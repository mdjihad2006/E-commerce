import 'package:bazario/app/app_colors.dart';
import 'package:bazario/features/home/products/ui/screens/product_list_screen.dart';
import 'package:bazario/features/home/ui/widgets/list_for_category.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductListScreen.name,
          arguments:
              "Electronics", // You can change this to dynamic value later if needed
        );
      },
      child: SizedBox(
        height: 150, // Container height to fix the size of the list view
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,

                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Shadow color
                        blurRadius: 8.0, // Shadow blur effect
                        spreadRadius: 1.0, // How much the shadow spreads
                        offset: Offset(0, 4), // Shadow offset (x, y)
                      )],
                      image: DecorationImage(
                        image: NetworkImage(categories[index]['image']!),
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.high
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade100),
                      ),
                    ),
                  ),
                  Text(
                    categories[index]['name']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.themeColor,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Sample category data
