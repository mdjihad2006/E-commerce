import 'package:bazario/core/network_caller/network_caller.dart';
import 'package:bazario/data/urls/urls.dart';
import 'package:bazario/features/common/data/models/slide_modal.dart';
import 'package:get/get.dart';

class HomeSliderController extends GetxController{
  bool _getSliderInProgress = false;

  String? _errorMessage;

  List<SlideModel> _sliderList =[];

  List<SlideModel> get sliders =>_sliderList;
  String? get errorMessage =>_errorMessage;
  bool get getSliderInProgress=> _getSliderInProgress;

  Future<bool> getSlider() async{
    bool isSuccess =false;
    _getSliderInProgress =true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(url: Urls.sliderUrl);
    if (response.isSuccess){
      List<SlideModel> list =[];
      for (Map<String,dynamic> data in response.responseData?['data']['results']?? []){
        list.add(SlideModel.fromJson(data));
      }
      _sliderList =list;
      isSuccess=true;
      _errorMessage = null;
    }
    else{
      _errorMessage = response.errorMessage;

    }
    _getSliderInProgress =false;
    update();
    return isSuccess;

  }
}