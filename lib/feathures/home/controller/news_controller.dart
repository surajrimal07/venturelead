import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/core/http/http_service.dart';
import 'package:venturelead/feathures/home/model/news_model.dart';

class NewsController extends GetxController {
  var newsList = <News>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void setLoading(bool loading) {
    isLoading.value = loading;
  }

  void setError(String? error) {
    errorMessage.value = error ?? '';
  }

  void setNewsList(List<News> news) {
    newsList.value = news;
  }

  Future<void> fetchNews() async {
    try {
      final httpService = Get.find<HttpService>();
      setLoading(true);

      final response = await httpService.dio
          .get('https://api.zorsha.com.np/news?_page=1&limit=20');

      if (response.statusCode == 200) {
        List<News> news = (response.data as List)
            .map((newsJson) => News.fromJson(newsJson))
            .toList();
        setNewsList(news);

        Get.showSnackbar(const GetSnackBar(
          title: 'Success',
          message: 'News fetched successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ));
      } else {
        setError(response.data['message']);
        Get.showSnackbar(GetSnackBar(
          title: 'Error',
          message: response.data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ));
      }
    } on DioException catch (e) {
      debugPrint('Failed to fetch news: $e');
      setError('Failed to fetch news: $e');
      Get.snackbar('Error', 'Failed to fetch news: $e',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } catch (e) {
      debugPrint('Failed to fetch news: $e');
      setError('Failed to fetch news: $e');
      Get.snackbar('Error', 'Failed to fetch news: $e',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red);
    } finally {
      setLoading(false);
    }
  }
}
