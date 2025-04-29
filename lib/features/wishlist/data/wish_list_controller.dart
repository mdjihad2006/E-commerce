import 'package:bazario/core/network_caller/network_caller.dart';
import 'package:bazario/data/urls/urls.dart';
import 'package:bazario/features/wishlist/data/modal/wish_list_modal.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<WishlistItem> _wishlist = [];
  List<WishlistItem> get wishlist => _wishlist;

  /// Fetch Wishlist
  Future<bool> fetchWishlist() async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.wishlist,
    );

    bool isSuccess = false;

    if (response.isSuccess) {
      final List data = response.responseData?['wishlist'] ?? [];

      _wishlist = data.map((e) => WishlistItem.fromJson(e)).toList();
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }

  /// Add to Wishlist (if needed)
  /*Future<bool> addToWishlist(WishlistItem wishlistItem) async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(
      url: Urls.getWishlist, // Or a separate POST endpoint
      body: wishlistItem.toJson(),
    );

    bool isSuccess = false;

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();
    return isSuccess;
  }*/
}
