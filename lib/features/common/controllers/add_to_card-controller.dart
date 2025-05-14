import 'package:bazario/core/network_caller/network_caller.dart';
import 'package:bazario/data/urls/urls.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController{
  bool _inProgrss = false;
  String? _errorMessage;

  bool get inProgress => _inProgrss;
  String? get errorMessage => _errorMessage;

  Future<bool> addToCart(String productId)async{
    bool isSuccess =false;
    _inProgrss = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(url: Urls.addToCartUrl,
        body: {'product':productId});
    if(response.isSuccess){
isSuccess =true;
_errorMessage=null;
    }else{
_errorMessage=response.errorMessage;
    }_inProgrss =false;
    update();
    return isSuccess;
  }

}