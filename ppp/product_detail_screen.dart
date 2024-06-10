import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'product_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;
  final ProductController productController = Get.find();

  ProductDetailScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Detail')),
      body: FutureBuilder(
        future: productController.fetchProductById(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final product = snapshot.data;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(product['image']),
                  SizedBox(height: 10),
                  Text(product['title'], style: TextStyle(fontSize: 24)),
                  SizedBox(height: 10),
                  Text('\$${product['price']}', style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text(product['description']),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
