import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/core/http/http_service.dart';
import 'package:venturelead/feathures/home/model/contact_model.dart';
import 'package:venturelead/feathures/home/model/faq_model.dart';

class FAQController extends GetxController {
  var faq = <FAQ>[].obs;

  void setFAQ(List<FAQ> newFaq) {
    faq.value = newFaq;
  }

  void setEmptyFAQ() {
    faq.value = [];
  }

  List<FAQ> getStoredFAQ() {
    return faq;
  }
}

Future<void> fetchFAQ() async {
  try {
    final httpService = Get.find<HttpService>();
    final faqController = Get.find<FAQController>();

    final response = await httpService.dio.get('/api/faq/getallfaq');

    if (response.statusCode == 200) {
      final List<dynamic> faqsJson = response.data['faqs'];
      final List<FAQ> faqs =
          faqsJson.map((json) => FAQ.fromJson(json)).toList();
      faqController.setFAQ(faqs);
    } else {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: response.data['message'],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ));
    }
  } on DioException catch (e) {
    debugPrint('Failed to fetch FAQs: $e');
    Get.snackbar('Error', 'Failed to fetch FAQs: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  } catch (e) {
    debugPrint('Failed to fetch FAQs: $e');
    Get.snackbar('Error', 'Failed to fetch FAQs: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  }
}

Future<void> sendContact(ContactUs contact) async {
  try {
    final httpService = Get.find<HttpService>();

    final response = await httpService.dio
        .post('/api/contact/create_contact', data: contact.toJson());

    if (response.statusCode == 200) {
      Get.showSnackbar(const GetSnackBar(
        title: 'Success',
        message: 'Message sent successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ));
    } else {
      Get.showSnackbar(GetSnackBar(
        title: 'Error',
        message: response.data['message'],
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ));
    }
  } on DioException catch (e) {
    debugPrint('Failed to send contacts: $e');
    Get.snackbar('Error', 'Failed to send contact: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  } catch (e) {
    debugPrint('Failed to send contacts: $e');
    Get.snackbar('Error', 'Failed to send Contacts: $e',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
  }
}
