import 'package:bazario/core/network_caller/network_caller.dart';
import 'package:bazario/features/auth/controller/auth_controller.dart';
import 'package:bazario/features/auth/ui/controllers/sign_in_controller.dart';
import 'package:bazario/features/auth/ui/controllers/sign_up_controller.dart';
import 'package:bazario/features/auth/ui/controllers/verify_otp_controller.dart';
import 'package:bazario/features/cart/controller/cart_controller.dart';
import 'package:bazario/features/categories/controller/category_controller.dart';
import 'package:bazario/features/categories/ui/screens/category_by_slug_controller.dart';
import 'package:bazario/features/common/controllers/mainbottom_navbar_controller.dart';
import 'package:bazario/features/common/controllers/sliders_controller.dart';
import 'package:bazario/features/wishlist/controller/add_to_wish_lsit.dart';
import 'package:bazario/features/wishlist/controller/get_wish_list_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(MainBottomNavBarController());
    Get.put(NetworkCaller());
    Get.put(HomeSliderController());
    Get.put(VerifyOtpController());
    Get.put(SignUpController());
    Get.put(SignInController());
    Get.put(AuthController());
    Get.put(CategoryController());
    Get.put(CategoryBySlugController());
    Get.put(CartListController());
    Get.put(GetWishListController());
    Get.put(AddToWishListController());
    Get.put(()=>VerifyOtpController());






  }

}