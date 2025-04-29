import 'package:bazario/core/network_caller/network_caller.dart';
import 'package:bazario/features/auth/controller/auth_controller.dart';
import 'package:bazario/features/auth/ui/controllers/category_controller.dart';
import 'package:bazario/features/auth/ui/controllers/sign_in_controller.dart';
import 'package:bazario/features/auth/ui/controllers/sign_up_controller.dart';
import 'package:bazario/features/auth/ui/controllers/verify_otp_controller.dart';
import 'package:bazario/features/common/controllers/mainbottom_navbar_controller.dart';
import 'package:bazario/features/common/controllers/sliders_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.put(MainBottomVavBarController());
    Get.put(NetworkCaller());
    Get.put(HomeSliderController());
    Get.put(VerifyOtpController());
    Get.put(SignUpController());
    Get.put(SignInController());

    Get.put(AuthController());
    Get.put(CategoryController());
    Get.put(()=>VerifyOtpController());






  }

}