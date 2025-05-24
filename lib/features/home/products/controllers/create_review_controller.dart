import 'package:get/get.dart';
import 'package:bazario/core/network_caller/network_caller.dart';
import 'package:bazario/data/urls/urls.dart';
import 'package:bazario/features/home/products/data/models/create_review_model.dart';

class CreateReviewController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  Future<bool> submitReview(CreateReviewModel model) async {
    _inProgress = true;
    update();

    // Log payload
    print("Submitting Review Payload: ${model.toJson()}");

    final response = await Get.find<NetworkCaller>().postRequest(
      url: Urls.createReview,
      body: model.toJson(),
    );

    _inProgress = false;

    if (response.isSuccess) {
      _errorMessage = null;
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage ?? 'Unexpected error';
      update();
      return false;
    }
  }
}
