
import 'package:bazario/core/network_caller/network_caller.dart';
import 'package:bazario/data/urls/urls.dart';
import 'package:bazario/features/common/data/product_model.dart';
import 'package:get/get.dart';

class ProductListController extends GetxController {
  final int _perPageDataCount = 30;

  int _currentPage = 0;

  int? _totalPage;

  bool _isInitialLoading = true;

  bool _isLoading = false;

  List<ProductModel> _productList = [];

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  int? get totalPage => _totalPage;

  List<ProductModel> get productList => _productList;

  bool get isLoading => _isLoading;

  bool get isInitialLoading => _isInitialLoading;

  Future<bool> getProductListByCategory(String categoryId) async {
    if (_totalPage != null && _currentPage > _totalPage!) {
      return true;
    }

    bool isSuccess = false;
    _currentPage++;
    if (!_isInitialLoading) {
      _isLoading = true;
    }
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.getProductUrl, queryParams: {
      'count': _perPageDataCount,
      'page': _currentPage,
      'category':categoryId
    });
    if (response.isSuccess) {
      List<ProductModel> list = [];
      for (Map<String, dynamic> data in response.responseData!['data']
      ['results']) {
        list.add(ProductModel.fromJson(data));
      }
      _productList.addAll(list);
      _totalPage = response.responseData!['data']['last_page'];

      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    if (!_isInitialLoading) {
      _isLoading = false;
    } else {
      _isInitialLoading = false;
    }

    update();

    return isSuccess;
  }
  Future<bool> getPopularProducts() async {
    if (_totalPage != null && _currentPage > _totalPage!) {
      return true;
    }

    bool isSuccess = false;
    _currentPage++;
    if (!_isInitialLoading) {
      _isLoading = true;
    }
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.getPopularProductUrl, queryParams: {
      'count': _perPageDataCount,
      'page': _currentPage,
      'category':'67c35af85e8a445235de197b'
    });
    if (response.isSuccess) {
      List<ProductModel> list = [];
      for (Map<String, dynamic> data in response.responseData!['data']
      ['results']) {
        list.add(ProductModel.fromJson(data));
      }
      _productList.addAll(list);
      _totalPage = response.responseData!['data']['last_page'];

      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    if (!_isInitialLoading) {
      _isLoading = false;
    } else {
      _isInitialLoading = false;
    }

    update();

    return isSuccess;
  }
  Future<bool> getSpecialProducts() async {
    if (_totalPage != null && _currentPage > _totalPage!) {
      return true;
    }

    bool isSuccess = false;
    _currentPage++;
    if (!_isInitialLoading) {
      _isLoading = true;
    }
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.getSpecialProductUrl, queryParams: {
      'count': _perPageDataCount,
      'page': _currentPage,
      'category':'67c35b395e8a445235de197e'
    });
    if (response.isSuccess) {
      List<ProductModel> list = [];
      for (Map<String, dynamic> data in response.responseData!['data']
      ['results']) {
        list.add(ProductModel.fromJson(data));
      }
      _productList.addAll(list);
      _totalPage = response.responseData!['data']['last_page'];

      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    if (!_isInitialLoading) {
      _isLoading = false;
    } else {
      _isInitialLoading = false;
    }

    update();

    return isSuccess;
  }
  Future<bool> getNewProducts() async {
    if (_totalPage != null && _currentPage > _totalPage!) {
      return true;
    }

    bool isSuccess = false;
    _currentPage++;
    if (!_isInitialLoading) {
      _isLoading = true;
    }
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .getRequest(url: Urls.getNewProductUrl, queryParams: {
      'count': _perPageDataCount,
      'page': _currentPage,
      'category':'67cd33432e43d538695ea4bc'
    });
    if (response.isSuccess) {
      List<ProductModel> list = [];
      for (Map<String, dynamic> data in response.responseData!['data']
      ['results']) {
        list.add(ProductModel.fromJson(data));
      }
      _productList.addAll(list);
      _totalPage = response.responseData!['data']['last_page'];

      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    if (!_isInitialLoading) {
      _isLoading = false;
    } else {
      _isInitialLoading = false;
    }

    update();

    return isSuccess;
  }


  Future<bool> refreshList(String categoryId) {
    _currentPage = 0;
    _productList = [];
    _isInitialLoading = true;
    return getProductListByCategory(categoryId);
  }
}