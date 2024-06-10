import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product_detail_screen.dart';
import 'product_controller.dart';

class MainScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product List')),
      body: Column(
        children: [
          // Add sort, limit, and category filters here
          Obx(() {
            if (productController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            return Expanded(
              child: ListView.builder(
                itemCount: productController.products.length,
                itemBuilder: (context, index) {
                  final product = productController.products[index];
                  return ListTile(
                    title: Text(product['title']),
                    subtitle: Text('\$${product['price']}'),
                    onTap: () {
                      Get.to(ProductDetailScreen(productId: product['id']));
                    },
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
