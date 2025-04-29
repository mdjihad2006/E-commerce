import 'package:bazario/core/network_caller/network_caller.dart';
import 'package:bazario/data/urls/urls.dart';
import 'package:bazario/features/auth/data/modals/sign_up_request_modal.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  bool _signUpInProgress = false;
  bool get signUpInProgress => _signUpInProgress;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> signUp(SignUpModel signUpModal) async {
    bool isSuccess = false;
    _signUpInProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: Urls.registrationUrl, body: signUpModal.toJson());

    if (response.isSuccess) {
      _errorMessage=null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

_signUpInProgress =false;
    update();
    return isSuccess;
  }
}
