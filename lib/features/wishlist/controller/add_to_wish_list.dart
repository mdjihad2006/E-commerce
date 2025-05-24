import 'package:bazario/core/network_caller/network_caller.dart';
import 'package:bazario/data/urls/urls.dart';
import 'package:get/get.dart';

class AddToWishListController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  // ✅ Track wishlist product IDs
  final Set<String> _favoriteProductIds = {};

  bool get inProgress => _inProgress;
  String? get errorMessage => _errorMessage;

  // ✅ Check if a product is in wishlist
  bool isFavorite(String productId) {
    return _favoriteProductIds.contains(productId);
  }

  // ✅ Toggle add/remove wishlist product
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

      // Toggle product in local wishlist
      if (_favoriteProductIds.contains(productId)) {
        _favoriteProductIds.remove(productId);
      } else {
        _favoriteProductIds.add(productId);
      }
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
