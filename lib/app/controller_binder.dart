import 'package:bazario/features/cart/ui/screens/controller/cart_list_controller.dart';
import 'package:bazario/features/categories/controller/get_category_by_slug.dart';
import 'package:bazario/features/wishlist/controller/add_to_wish_list.dart';
import 'package:bazario/features/wishlist/controller/get_wish_list_controller.dart';
import 'package:get/get.dart';

// Your controller imports
import 'package:bazario/core/network_caller/network_caller.dart';
import 'package:bazario/features/auth/controller/auth_controller.dart';
import 'package:bazario/features/auth/ui/controllers/sign_in_controller.dart';
import 'package:bazario/features/auth/ui/controllers/sign_up_controller.dart';
import 'package:bazario/features/auth/ui/controllers/verify_otp_controller.dart';
import 'package:bazario/features/categories/controller/category_controller.dart';
import 'package:bazario/features/common/controllers/mainbottom_navbar_controller.dart';
import 'package:bazario/features/common/controllers/sliders_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MainBottomNavBarController());
    Get.put(NetworkCaller());
    Get.put(HomeSliderController());
    Get.put(SignUpController());
    Get.put(SignInController());
    Get.put(AuthController());
    Get.put(CategoryController());
    Get.put(CategoryByIdController());
    Get.put(CartListController());
    Get.put(GetWishListController());
    Get.put(AddToWishListController());

    // Only one of these! Choose either eager or lazy:
    Get.lazyPut(() => VerifyOtpController());
  }
}
