import 'package:bazario/core/network_caller/network_caller.dart';
import 'package:bazario/core/widgets/show_snackbar.dart';
import 'package:bazario/data/urls/urls.dart';
import 'package:bazario/features/home/products/data/models/get_review_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  var reviews = <GetReviewModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  bool _deleteReview =false;


  Future<void> fetchReviewsByProductId(String productId) async {
    isLoading.value = true;
    final response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.getReviewList,
      queryParams: {
        'product': productId,
      },
    );

    if (response.isSuccess) {
      try {
        final results = response.responseData!['data']['results'] as List;
        reviews.value = results.map((e) => GetReviewModel.fromJson(e)).toList();
        errorMessage.value = '';
      } catch (e) {
        errorMessage.value = 'Parsing error: ${e.toString()}';
      }
    } else {
      errorMessage.value =
          response.responseData?['msg'] ?? 'Failed to load reviews';
    }
    isLoading.value = false;
  }
  Future<bool> DeleteReview(BuildContext context, String reviewId) async {
    bool isSuccess = false;
    _deleteReview = true;
    update();

    final NetworkResponse response =
    await Get.find<NetworkCaller>().deleteRequest(
      url: Urls.deleteReview(reviewId),
    );

    if (response.isSuccess) {
      reviews.removeWhere((item) => item.id == reviewId);
      update();

      isSuccess = true;
    } else {
      showSnackBarMessage(context, 'somthing is wrong');
    }

    _deleteReview = false;
    update();
    return isSuccess;
  }
}
