import 'package:bazario/data/urls/urls.dart';
import 'package:bazario/features/auth/data/modals/category_modal.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryController extends GetxController {
  final categories = <CategoryModel>[].obs;
  final isLoading = false.obs;

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      var url = Urls.category; // Replace with your actual base URL
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final List<dynamic> results = body['data']['results'];

        categories.value = results.map((item) => CategoryModel.fromJson(item)).toList();
      } else {
        Get.snackbar("Error", "Failed to load categories");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }
}
