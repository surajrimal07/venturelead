import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:venturelead/core/http/http_service.dart';
import 'package:venturelead/feathures/home/model/news_model.dart';

class NewsController extends GetxController {
  var newsList = <News>[].obs;
  var searchNewsList = <News>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var trendingNews = <News>[].obs;

  void setLoading(bool loading) {
    isLoading.value = loading;
  }

  void setError(String? error) {
    errorMessage.value = error ?? '';
  }

  void setNewsList(List<News> news) {
    newsList.value = news;
  }

  void setSearchNewsList(List<News> news) {
    searchNewsList.value = news;
  }

  void setTrendingNews(List<News> news) {
    trendingNews.value = news;
  }

  Future<void> fetchNews(String keyword) async {
    try {
      final httpService = Get.find<HttpService>();
      setLoading(true);

      final response = await httpService.dio
          .get('https://api.surajr.com.np/news?keyword=$keyword');

      if (response.statusCode == 200) {
        List<News> news = (response.data as List)
            .map((newsJson) => News.fromJson(newsJson))
            .toList();
        setNewsList(news);
      } else {
        setError(response.data['message']);
      }
    } on DioException catch (e) {
      debugPrint('Failed to fetch news: $e');
      setError('Failed to fetch news: $e');
    } catch (e) {
      debugPrint('Failed to fetch news: $e');
      setError('Failed to fetch news: $e');
    } finally {
      setLoading(false);
    }
  }

  Future<void> fetchTrendingNews() async {
    try {
      final httpService = Get.find<HttpService>();
      setLoading(true);

      final response = await httpService.dio
          .get('https://api.surajr.com.np/news?keyword=trending');

      if (response.statusCode == 200) {
        List<News> news = (response.data as List)
            .map((newsJson) => News.fromJson(newsJson))
            .toList();
        setTrendingNews(news);
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

  Future<bool> updateNewsView(String key) async {
    try {
      final httpService = Get.find<HttpService>();

      final response = await httpService.dio
          .get('https://api.surajr.com.np/updatenewsview?id=$key');

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> searchNews(String keyword) async {
    try {
      final httpService = Get.find<HttpService>();
      setLoading(true);

      final response = await httpService.dio
          .get('https://api.surajr.com.np/news?keyword=$keyword&limit=20');

      if (response.statusCode == 200) {
        List<News> news = (response.data as List)
            .map((newsJson) => News.fromJson(newsJson))
            .toList();
        setSearchNewsList(news);
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
