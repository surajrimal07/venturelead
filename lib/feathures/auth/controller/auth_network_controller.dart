import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/core/http/http_service.dart';
import 'package:venturelead/feathures/auth/controller/auth_controller.dart';
import 'package:venturelead/feathures/auth/model/user_model.dart';

Future<bool> handleLoginController(String email, String password) async {
  try {
    final httpService = Get.find<HttpService>();
    final AuthController authController = Get.find<AuthController>();

    authController.updateAuthState(authController.authState.value.copyWith(
      isLoading: true,
    ));

    final response = await httpService.dio.post(
      '/user/login',
      data: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final user = User.fromJson(response.data['data']);
      authController.updateAuthState(authController.authState.value.copyWith(
        isLoading: false,
        authEntity: user,
      ));

      Get.showSnackbar(const GetSnackBar(
        title: 'Success',
        message: 'Login successful',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ));

      return true;
    } else {
      authController.updateAuthState(authController.authState.value.copyWith(
        isLoading: false,
        error: response.data['message'],
      ));

      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: response.data['message'],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ));

      return false;
    }
  } on DioException catch (e) {
    debugPrint('Login failed: $e');
    Get.snackbar('Error', 'Login failed: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  } catch (e) {
    debugPrint('Login failed: $e');
    Get.snackbar('Error', 'Login failed: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  }

  return false;
}
