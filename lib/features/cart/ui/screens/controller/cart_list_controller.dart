import 'package:bazario/core/network_caller/network_caller.dart';
import 'package:bazario/data/urls/urls.dart';
import 'package:bazario/features/cart/data/model/cart_model.dart';

import 'package:get/get.dart';

class CartListController extends GetxController {
  bool _getCartListInProgress = false;

  bool _removeFromCartListInProgress = false;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _removeFromCartErrorMessage;

  String? get removeFromCartErrorMessage => _removeFromCartErrorMessage;

  List<CartItemModel> _cartItemList = [];

  List<CartItemModel> get cartItemList => _cartItemList;

  bool get getCartListInProgress => _getCartListInProgress;

  bool get removeFromCartListInProgress => _removeFromCartListInProgress;

  Future<bool> getCartList() async {
    bool isSuccess = false;
    _getCartListInProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.cartListUrl,
    );

    if (response.isSuccess) {
      List<CartItemModel> list = [];
      for (Map<String, dynamic> json in response.responseData!['data']
          ['results']) {
        list.add(CartItemModel.fromJson(json));
      }
      _cartItemList = list;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getCartListInProgress = false;
    update();
    return isSuccess;
  }

  void updateProduct(String cartId, int quantity) {
    // Normal api call
    for (CartItemModel cartItem in _cartItemList) {
      if (cartItem.id == cartId) {
        cartItem.quantity = quantity;
        break;
      }
    }
    update();
  }

  Future<bool> removeFromCart(String cartId) async {
    bool isSuccess = false;
    _removeFromCartListInProgress = true;
    update();
    final NetworkResponse response =
        await Get.find<NetworkCaller>().deleteRequest(
      url: Urls.deleteFromCartListUrl(cartId),
    );
    if (response.isSuccess) {
      _cartItemList.removeWhere((e) => e.id == cartId);
      isSuccess = true;
    } else {
      _removeFromCartErrorMessage = response.errorMessage;
    }
    _removeFromCartListInProgress = false;
    update();
    return isSuccess;
  }

  int get totalPrice {
    int total = 0;
    for (CartItemModel cartItem in _cartItemList) {
      //total = (cartItem.productModel.currentPrice * cartItem.quantity).toInt();
      total += (cartItem.productModel.currentPrice * cartItem.quantity);
    }
    return total;
  }
}