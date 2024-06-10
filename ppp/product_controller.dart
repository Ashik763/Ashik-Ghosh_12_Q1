import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductController extends GetxController {
  var products = [].obs;
  var categories = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchProducts(
      {String sort = 'asc', int limit = 10, String category = ''}) async {
    isLoading(true);
    try {
      var url = 'https://fakestoreapi.com/products';
      if (category.isNotEmpty) {
        url = 'https://fakestoreapi.com/products/category/$category';
      } else {
        url += '?sort=$sort&limit=$limit';
      }
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        products.value = json.decode(response.body);
      }
    } finally {
      isLoading(false);
    }
  }

  void fetchCategories() async {
    final url = 'https://fakestoreapi.com/products/categories';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      categories.value = json.decode(response.body);
    }
  }

  Future<dynamic> fetchProductById(int id) async {
    final url = 'https://fakestoreapi.com/products/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }
}
