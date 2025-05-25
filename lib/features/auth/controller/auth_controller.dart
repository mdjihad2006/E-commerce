import 'dart:convert';
import 'package:bazario/data/modals/user_modal.dart';
import 'package:flutter/material.dart'; // ✅ fixed capitalization
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final String _tokenKey = 'token';
  final String _userDataKey = 'user-data';

  String? token;
  UserModel? user;

  @override
  void onInit() {
    super.onInit();
    getUserData(); // Load token and user data on initialization
  }

  Future<void> saveUserData(String accessToken, UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, accessToken);
    await sharedPreferences.setString(_userDataKey, jsonEncode(userModel.toJson()));

    token = accessToken;
    user = userModel;
    print('Saved token: $token'); // Debug log
    update(); // Notify listeners if using GetBuilder
  }

  Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(_tokenKey);
    String? userData = sharedPreferences.getString(_userDataKey);

    if (userData != null) {
      user = UserModel.fromJson(jsonDecode(userData));
    }

    print('Loaded token: $token'); // Debug log
    update();
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? accessToken = sharedPreferences.getString(_tokenKey);
    await getUserData();

    return accessToken != null && accessToken.isNotEmpty;
  }

  Future<void> clearUserData() async {
    try {
      final sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.remove(_tokenKey);
      await sharedPreferences.remove(_userDataKey);
      token = null;
      user = null;
      print('Cleared token');
      // Avoid calling update() unless necessary for UI
      // update(); // Comment out or remove unless UI needs to refresh
    } catch (e) {
      print('Error clearing user data: $e');
      throw Exception('Failed to clear user data: $e');
    }
  }

  bool isValidUser() {
    print('isValidUser: token = $token'); // Debug print
    return token != null && token!.isNotEmpty;
  }

  Future<bool> isValidUserAsync() async {
    if (token == null) {
      await getUserData();
    }
    print('isValidUserAsync: token = $token');
    return token != null && token!.isNotEmpty;
  }
}
