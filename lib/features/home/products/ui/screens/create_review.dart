import 'package:bazario/app/app_colors.dart';
import 'package:flutter/material.dart';

class CreateReview extends StatefulWidget {
  const CreateReview({super.key});

  static const String name = "/create-review";

  @override
  State<CreateReview> createState() => _CreateReviewState();
}

class _CreateReviewState extends State<CreateReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        toolbarHeight: 70,
        title: Text('Create Review'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'First name'
              ),
            ),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(
              hintText: 'Last name'
            ),),
            SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(hintText: 'write review'),
                maxLines: 8),
            SizedBox(height: 10),

            ElevatedButton(onPressed: () {}, child: Text("Review")),
          ],
        ),
      ),
     // bottomNavigationBar: MainBottomNavbarScreen(),
    );
  }
}
