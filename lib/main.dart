import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'news_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: NewsApp(),
    );
  }
}
