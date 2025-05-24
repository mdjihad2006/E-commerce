// cart_list_controller.dart

import 'package:bazario/core/network_caller/network_caller.dart';
import 'package:bazario/data/urls/urls.dart';
import 'package:bazario/features/cart/data/model/cart_model.dart';
import 'package:get/get.dart';

class CartListController extends GetxController {
  bool _getCartListInProgress = false;
  bool _removeFromCartListInProgress = false;

  String? _errorMessage;
  String? _removeFromCartErrorMessage;

  List<CartItemModel> _cartItemList = [];

  // Getters
  String? get errorMessage => _errorMessage;
  String? get removeFromCartErrorMessage => _removeFromCartErrorMessage;
  List<CartItemModel> get cartItemList => _cartItemList;
  bool get getCartListInProgress => _getCartListInProgress;
  bool get removeFromCartListInProgress => _removeFromCartListInProgress;

  /// Fetch Cart Items
  Future<bool> getCartList() async {
    bool isSuccess = false;
    _getCartListInProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.cartListUrl,
    );

    if (response.isSuccess) {
      _cartItemList = (response.responseData!['data']['results'] as List)
          .map((json) => CartItemModel.fromJson(json))
          .toList();
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getCartListInProgress = false;
    update();
    return isSuccess;
  }

  /// Update Quantity Locally
  void updateProduct(String cartId, int quantity) {
    for (CartItemModel item in _cartItemList) {
      if (item.id == cartId) {
        item.quantity = quantity;
        break;
      }
    }
    update();
  }

  /// Remove Item from Cart
  Future<bool> removeFromCart(String cartId) async {
    bool isSuccess = false;
    _removeFromCartListInProgress = true;
    update();

    final NetworkResponse response =
    await Get.find<NetworkCaller>().deleteRequest(
      url: Urls.deleteFromCartListUrl(cartId),
    );

    if (response.isSuccess) {
      _cartItemList.removeWhere((item) => item.id == cartId);
      update();

      isSuccess = true;
    } else {
      _removeFromCartErrorMessage = response.errorMessage;
    }

    _removeFromCartListInProgress = false;
    update();
    return isSuccess;
  }

  /// Total Cart Value
  int get totalPrice {
    return _cartItemList.fold(
      0,
          (total, item) => total + (item.productModel.currentPrice * item.quantity),
    );
  }
}
