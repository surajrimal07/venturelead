import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NewsSummaryController extends GetxController {
  var isLoading = false.obs;
  var summary = ''.obs;
  var errorMessage = ''.obs;

  Future<void> fetchNewsSummary(String url) async {
    isLoading(true);
    errorMessage('');
    try {
      final response = await http.get(
        Uri.parse('https://summary.surajr.com.np/summarize?url=$url'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        final List<dynamic> data = json.decode(responseBody);
        if (data.isNotEmpty && data[0].split(" ").length >= 5) {
          summary(data[0]);
        } else {
          errorMessage('Received invalid summary data.');
        }
      } else {
        throw Exception('Failed to load summary');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
