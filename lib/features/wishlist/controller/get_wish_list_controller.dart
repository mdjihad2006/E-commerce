import 'package:bazario/core/network_caller/network_caller.dart';
import 'package:bazario/core/widgets/show_snackbar.dart';
import 'package:bazario/data/urls/urls.dart';
import 'package:bazario/features/cart/data/model/cart_model.dart';
import 'package:bazario/features/wishlist/data/model/wish_list_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

class GetWishListController extends GetxController {
  bool _getWishListInProgress = false;

  bool _removeFromWishListInProgress = false;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  String? _removeFromWishListErrorMessage;

  String? get removeFromWishListErrorMessage => _removeFromWishListErrorMessage;

  List<WishListModel> _wishListItemList = [];

  List<WishListModel> get WishItemList => _wishListItemList;

  bool get getCartListInProgress => _getWishListInProgress;

  bool get removeFromWishListInProgress => _removeFromWishListInProgress;

  Future<bool> getWishList() async {
    bool isSuccess = false;
    _getWishListInProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: Urls.getWishListUrl,
    );

    if (response.isSuccess) {
      List<WishListModel> list = [];
      for (Map<String, dynamic> json in response.responseData!['data']
      ['results']) {
        list.add(WishListModel.fromJson(json));
      }
      _wishListItemList = list;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getWishListInProgress = false;
    update();
    return isSuccess;
  }

  void updateProduct(String cartId, int quantity) {
    // Normal api call
    for (WishListModel cartItem in _wishListItemList) {
      if (cartItem.id == cartId) {
        cartItem.quantity = quantity;
        break;
      }
    }
    update();
  }

  Future<bool> removeFromWIshList( BuildContext context,String wishListId) async {
    bool isSuccess = false;
    _removeFromWishListInProgress = true;
    update();
    final NetworkResponse response =
    await Get.find<NetworkCaller>().deleteRequest(
      url: Urls.deleteFromWishListUrl(wishListId),
    );
    if (response.isSuccess) {
      _wishListItemList.removeWhere((item) => item.id == wishListId);
      showSnackBarMessage(context,'successfully delete item ');
      update();
      isSuccess = true;
    } else {
      _removeFromWishListErrorMessage = response.errorMessage;
    }
    _removeFromWishListInProgress = false;
    update();
    return isSuccess;
  }

  int get totalPrice {
    int total = 0;
    for (WishListModel cartItem in _wishListItemList) {
      //total = (cartItem.productModel.currentPrice * cartItem.quantity).toInt();
      total += (cartItem.productModel.currentPrice * cartItem.quantity);
    }
    return total;
  }
}