import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:venturelead/core/http/http_service.dart';
import 'package:venturelead/core/toast.dart';
import 'package:venturelead/core/utils/shared_prefs.dart';
import 'package:venturelead/feathures/auth/controller/auth_controller.dart';
import 'package:venturelead/feathures/auth/model/user_model.dart';
import 'package:venturelead/feathures/auth/view/view/login_auth.dart';

Future<bool> handleLoginController(String email, String password,
    {bool refresh = false}) async {
  try {
    final httpService = Get.find<HttpService>();
    final AuthController authController = Get.find<AuthController>();
    final userPrefs = UserSharedPrefss();

    authController.updateAuthState(authController.authState.value.copyWith(
      isLoading: true,
    ));

    final response = await httpService.dio.post(
      '/api/user/login',
      data: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final user = User.fromJson(response.data['data']);
      authController.updateAuthState(authController.authState.value.copyWith(
        isLoading: false,
        authEntity: user,
      ));

      userPrefs.saveData<String>('bearertoken', response.data['token']);

      if (refresh) {
        CustomToast.showToast('Refreshed successfully');
      } else {
        Get.showSnackbar(const GetSnackBar(
          title: 'Success',
          message: 'Login successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ));
      }

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

Future<bool> handleSignupController(
    String email, String password, String userName) async {
  try {
    final httpService = Get.find<HttpService>();
    final AuthController authController = Get.find<AuthController>();

    authController.updateAuthState(authController.authState.value.copyWith(
      isLoading: true,
    ));

    final response = await httpService.dio.post(
      '/api/user/signup',
      data: {'email': email, 'password': password, 'username': userName},
    );

    if (response.statusCode == 201) {
      Get.to(const LoginScreen());
      authController.updateAuthState(
          authController.authState.value.copyWith(isLoading: false));

      Get.showSnackbar(const GetSnackBar(
        title: 'Success',
        message: 'Signup successful, please login.',
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

Future<bool> handleSendOTPController(String email) async {
  try {
    final httpService = Get.find<HttpService>();
    final AuthController authController = Get.find<AuthController>();

    authController.updateAuthState(authController.authState.value.copyWith(
      isLoading: true,
    ));

    final response = await httpService.dio.post(
      '/api/user/forgotpassword',
      data: {'email': email},
    );

    if (response.statusCode == 200) {
      authController.updateAuthState(
          authController.authState.value.copyWith(isLoading: false));

      Get.showSnackbar(const GetSnackBar(
        title: 'Success',
        message: 'Please check your email for OTP.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
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

Future<bool> handleVerifyOTPController(String email, int otp) async {
  try {
    final httpService = Get.find<HttpService>();
    final AuthController authController = Get.find<AuthController>();

    authController.updateAuthState(authController.authState.value.copyWith(
      isLoading: true,
    ));

    final response = await httpService.dio.post(
      '/api/user/verify-otp',
      data: {'email': email, 'otp': otp},
    );

    if (response.statusCode == 200) {
      Get.to(const LoginScreen());
      authController.updateAuthState(
          authController.authState.value.copyWith(isLoading: false));

      Get.showSnackbar(const GetSnackBar(
        title: 'Success',
        message: 'Please create your new password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
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

Future<bool> handleChangePasswordController(
    String password, String email) async {
  try {
    final httpService = Get.find<HttpService>();
    final AuthController authController = Get.find<AuthController>();

    authController.updateAuthState(authController.authState.value.copyWith(
      isLoading: true,
    ));

    final response = await httpService.dio.post(
      '/api/user/updateuser',
      data: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      Get.to(const LoginScreen());
      authController.updateAuthState(
          authController.authState.value.copyWith(isLoading: false));

      Get.showSnackbar(const GetSnackBar(
        title: 'Success',
        message: 'Please login to continue.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
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

Future<bool> handleUpdateController(FormData formData) async {
  try {
    final httpService = Get.find<HttpService>();
    final AuthController authController = Get.find<AuthController>();

    authController.updateAuthState(authController.authState.value.copyWith(
      isLoading: true,
    ));

    final response = await httpService.dio.post(
      '/api/user/updateuser',
      data: formData,
      options: Options(
        headers: {
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    if (response.statusCode == 200) {
      final user = User.fromJson(response.data['data']);
      authController.updateAuthState(authController.authState.value.copyWith(
        isLoading: false,
        authEntity: user,
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
    debugPrint('Update failed: $e');
    Get.snackbar('Error', 'Update failed: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  } catch (e) {
    debugPrint('Update failed: $e');
    Get.snackbar('Error', 'Update failed: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  }

  return false;
}
