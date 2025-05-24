import 'package:bazario/core/widgets/show_snackbar.dart';
import 'package:bazario/features/home/products/controllers/get_revew_controller.dart';
import 'package:bazario/features/home/products/data/models/get_review_model.dart';
import 'package:bazario/features/home/products/ui/screens/create_review.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReviewsScreen extends StatefulWidget {
  final String productId;
  const ReviewsScreen({super.key, required this.productId});
  static final String name = "/review";


  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final controller = Get.put(ReviewController());
  bool _deleteInProgress=false;

  @override
  void initState() {
    super.initState();
    controller.fetchReviewsByProductId(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Get.to(() => CreateReview(productId: widget.productId));
          if (result == true) controller.fetchReviewsByProductId(widget.productId);
        },
        label: Text("Add Review"),
        icon: Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
      ),
      appBar: AppBar(
        title: const Text('Product Reviews'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) return const Center(child: CircularProgressIndicator());
        if (controller.errorMessage.isNotEmpty) return Center(child: Text(controller.errorMessage.value));
        if (controller.reviews.isEmpty) return const Center(child: Text('No reviews found.'));

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.reviews.length,
          itemBuilder: (_, index) {
            final review = controller.reviews[index];
            final name = '${review.userModel.firstName} ${review.userModel.lastName}';
            final date = DateFormat('dd MMM yyyy').format(review.createdAt.toLocal());

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.deepPurple.shade100,
                            child: Text(name.isNotEmpty ? name[0].toUpperCase() : '?',
                                style: TextStyle(color: Colors.deepPurple)),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                      Visibility(
                        visible: _deleteInProgress == false,
                        replacement: const CircularProgressIndicator(),
                        child: IconButton(
                          onPressed: () async {
                            _deleteInProgress = true;
                            setState(() {});
                            final bool isSuccess =
                            await Get.find<ReviewController>()
                                .DeleteReview(context,widget.productId);
                            showSnackBarMessage(context, 'success');
                            _deleteInProgress = false;
                            setState(() {});
                            if (isSuccess == false) {
                              showSnackBarMessage(
                                  context,
                                  'something wrong',
                                  true);
                            }
                          },
                          icon: const Icon(Icons.more_vert),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(review.comment, style: const TextStyle(fontSize: 14, height: 1.4)),
                ],
              ),
            );
          },
        );
      }),
      backgroundColor: Colors.grey.shade100,
    );
  }
}
