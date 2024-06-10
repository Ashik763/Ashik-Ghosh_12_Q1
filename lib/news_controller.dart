import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsController extends GetxController {
  var keywords = ''.obs;
  var selectedDate = ''.obs;
  var selectedLanguage = 'en'.obs;
  var selectedSortBy = 'publishedAt'.obs;
  var newsList = [].obs;
  var isLoading = false.obs;

  void fetchNews() async {
    isLoading.value = true;
    final url =
        'https://newsapi.org/v2/everything?q=${keywords.value}&from=${selectedDate.value}&sortBy=${selectedSortBy.value}&language=${selectedLanguage.value}&apiKey=2212928139c44403b798c0e21d642581';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      newsList.value = json.decode(response.body)['articles'];
    } else {
      // Handle errors
      print('Failed to load news');
    }
    isLoading.value = false;
  }
}
