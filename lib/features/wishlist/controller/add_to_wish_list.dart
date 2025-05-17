import 'package:bazario/core/network_caller/network_caller.dart';
import 'package:bazario/data/urls/urls.dart';
import 'package:get/get.dart';

class AddToWishListController extends GetxController {
  bool _inProgress = false;

  String? _errorMessage;

  bool get inProgress => _inProgress;

  String? get errorMessage => _errorMessage;

  Future<bool> addToWishList(String productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Urls.addToWishList, body: {
      'product': productId,
    });
    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}