import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:venturelead/core/http/http_service.dart';
import 'package:venturelead/core/toast.dart';
import 'package:venturelead/feathures/auth/controller/auth_controller.dart';
import 'package:venturelead/feathures/home/controller/companies_controller.dart';

final CompanyController companyController = Get.find<CompanyController>();
final httpService = Get.find<HttpService>();
final AuthController authController = Get.find<AuthController>();

Future<dynamic> fetchCompanies() async {
  try {
    companyController
        .updateCompanyState(companyController.companyState.value.copyWith(
      isLoading: true,
    ));

    final response = await httpService.dio.get('/api/company/get_new_company');

    if (response.statusCode == 200) {
      final companies = response.data['companies'] as List<dynamic>;

      companyController.setCompanyEntity(companies);

      CustomToast.showToast('Companies fetched successfully');

      return companies;
    } else {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: response.data['message'],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 1),
      ));

      return [];
    }
  } on DioException catch (e) {
    debugPrint('Fetch failed: $e');
    Get.snackbar('Error', 'Fetch failed: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  } catch (e) {
    debugPrint('Fetch failed: $e');
    Get.snackbar('Error', 'Fetch failed: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  }

  return false;
}

Future<dynamic> fetchAllCompanies() async {
  try {
    final response = await httpService.dio.get('/api/company/get_all_company');

    if (response.statusCode == 200) {
      final companies = response.data['companies'] as List<dynamic>;

      companyController.updateAllCompanyState(companies);

      CustomToast.showToast('Companies fetched successfully');

      return companies;
    } else {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: response.data['message'],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 1),
      ));

      return [];
    }
  } on DioException catch (e) {
    debugPrint('Fetch failed: $e');
    Get.snackbar('Error', 'Fetch failed: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  } catch (e) {
    debugPrint('Fetch failed: $e');
    Get.snackbar('Error', 'Fetch failed: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  }

  return false;
}

Future<dynamic> fetchFeaturedCompanies() async {
  try {
    companyController
        .updateCompanyState(companyController.companyState.value.copyWith(
      isLoading: true,
    ));

    final response = await httpService.dio.get('/api/company/get_new_company');

    if (response.statusCode == 200) {
      final companies = response.data['companies'] as List<dynamic>;

      companyController.setCompanyEntity(companies);

      Get.showSnackbar(const GetSnackBar(
        title: 'Success',
        message: 'Companies fetched successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ));

      return companies;
    } else {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: response.data['message'],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ));

      return [];
    }
  } on DioException catch (e) {
    debugPrint('Fetch failed: $e');
    Get.snackbar('Error', 'Fetch failed: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  } catch (e) {
    debugPrint('Fetch failed: $e');
    Get.snackbar('Error', 'Fetch failed: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  }

  return false;
}

Future<bool> handleConnection(
    userId, companyId, reason, subject, message, email, linkedinurl) async {
  try {
    authController.updateAuthState(authController.authState.value.copyWith(
      isLoading: true,
    ));

    var data = {
      'userId': userId,
      'companyId': companyId,
      'reason': reason,
      'subject': subject,
      'message': message,
      'email': email,
      'linkedinurl': linkedinurl,
    };

    final response =
        await httpService.dio.post('/api/user/createconnection', data: data);

    if (response.statusCode == 201) {
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
    Get.snackbar('Error', 'Update failed: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  } catch (e) {
    Get.snackbar('Error', 'Update failed: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  }

  return false;
}

Future<bool> handleCompanyClaim(FormData formData) async {
  try {
    final response =
        await httpService.dio.post('/api/claim/company-claims', data: formData);

    if (response.statusCode == 201) {
      return true;
    } else {
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
    Get.snackbar('Error', 'Update failed: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  } catch (e) {
    Get.snackbar('Error', 'Update failed: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  }

  return false;
}
