import 'package:bazario/core/network_caller/network_caller.dart';
import 'package:bazario/data/modals/user_modal.dart';
import 'package:bazario/data/urls/urls.dart';
import 'package:bazario/features/auth/controller/auth_controller.dart';
import 'package:bazario/features/auth/data/modals/sign_in_modal.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;


  Future<bool> signIn(SignInModal signInModel) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
    await Get.find<NetworkCaller>().postRequest(
      url: Urls.signIn,
      body: signInModel.toJson(),
    );
    if (response.isSuccess) {
      // Save user data
      UserModel userModel = UserModel.fromJson(response.responseData!['data']['user']);
      // Save user token
      String accessToken = response.responseData!['data']['token'];
      await Get.find<AuthController>().saveUserData(accessToken, userModel);

      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}