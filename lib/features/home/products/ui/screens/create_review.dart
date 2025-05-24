import 'package:bazario/features/home/products/controllers/create_review_controller.dart';
import 'package:bazario/features/home/products/data/models/create_review_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReview extends StatefulWidget {
  final String productId;

  const CreateReview({super.key, required this.productId});

  static const String name = "/create-review";

  @override
  State<CreateReview> createState() => _CreateReviewState();
}

class _CreateReviewState extends State<CreateReview> {
  final TextEditingController _commentController = TextEditingController();
  int _rating = 5;

  final CreateReviewController _reviewController = Get.put(CreateReviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Review')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(hintText: 'Write review'),
              maxLines: 8,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text("Rating: "),
                DropdownButton<int>(
                  value: _rating,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _rating = value);
                    }
                  },
                  items: List.generate(
                    5,
                        (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1}'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitReview,
              child: const Text("Submit Review"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitReview() async {
    final model = CreateReviewModel(
      product: widget.productId,
      rating: _rating,
      comment: _commentController.text,
    );

    final isSuccess = await _reviewController.submitReview(model);

    if (isSuccess) {
      Get.back(result: true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_reviewController.errorMessage ?? "Failed to submit"),
        backgroundColor: Colors.red,
      ));
    }
  }
}
