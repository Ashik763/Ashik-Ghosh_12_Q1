import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product_controller.dart';
import 'main_screen.dart';

class CategoryScreen extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
          itemCount: productController.categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
          ),
          itemBuilder: (context, index) {
            final category = productController.categories[index];
            return GestureDetector(
              onTap: () {
                productController.fetchProducts(category: category);
                Get.to(MainScreen());
              },
              child: Card(
                child: Center(
                  child: Text(category),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
