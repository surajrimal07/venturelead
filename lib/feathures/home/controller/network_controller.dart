import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:venturelead/core/http/http_service.dart';
import 'package:venturelead/core/utils/shared_prefs.dart';
import 'package:venturelead/feathures/home/controller/companies_controller.dart';

Future<dynamic> fetchCompanies() async {
  try {
    final httpService = Get.find<HttpService>();
    final CompanyController companyController = Get.find<CompanyController>();
    final userPrefs = UserSharedPrefss();

    companyController
        .updateCompanyState(companyController.companyState.value.copyWith(
      isLoading: true,
    ));

    final response = await httpService.dio.get('/api/company/get_all_company');

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
