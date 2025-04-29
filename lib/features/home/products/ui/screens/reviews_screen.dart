import 'package:bazario/app/app_colors.dart';
import 'package:bazario/features/common/ui/screens/main_bottom_navbar_screen.dart';
import 'package:bazario/features/home/products/ui/screens/create_review.dart';
import 'package:flutter/material.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});
  static const String name = "/review";

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final List<Map<String, dynamic>> reviews = [
    {
      "name": "John Doe",
      "rating": 4.5,
      "comment": "Amazing product! Totally worth the price.",
      "date": "March 25, 2025",
    },
    {
      "name": "Jasmin",
      "rating": 5.0,
      "comment": "Excellent quality and fast delivery. Loved it!",
      "date": "April 01, 2025",
    },
    {
      "name": "Rana",
      "rating": 3.5,
      "comment": "Good, but the packaging could be better.",
      "date": "April 03, 2025",
    },
    {
      "name": "Mukul",
      "rating": 3.5,
      "comment": "Good, but the packaging could be better.",
      "date": "April 03, 2025",
    },
    {
      "name": "Sumon",
      "rating": 3.5,
      "comment": "Good, but the packaging could be better.",
      "date": "April 03, 2025",
    },
    {
      "name": "Tuser",
      "rating": 3.5,
      "comment": "Good, but the packaging could be better.",
      "date": "April 03, 2025",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
        ),
        title: const Text('Reviews'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                final String name = review['name'] ?? '';
                final double rating = review['rating'] ?? 0.0;
                final String comment = review['comment'] ?? '';
                final String date = review['date'] ?? '';

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.teal.shade100,
                              child: Text(name.isNotEmpty ? name[0] : '?'),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  date,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: List.generate(5, (starIndex) {
                            return Icon(
                              starIndex < rating.round()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 20,
                            );
                          }),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          comment,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          _priceAndCartSection(),
        ],
      ),
      //bottomNavigationBar: MainBottomNavbarScreen(),
    );
  }

  Widget _priceAndCartSection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: const BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Reviews",
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
                SizedBox(height: 4),
                Text(
                  "(1000)",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 80,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, CreateReview.name);
                },
                child: Icon(Icons.add, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
