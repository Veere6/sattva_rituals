import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'theme/app_theme.dart';
import 'views/home_view.dart';
import 'controllers/product_controller.dart';
import 'controllers/cart_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  
  // Initialize controllers
  Get.put(ProductController());
  Get.put(CartController());
  
  runApp(const SattvaRitualsApp());
}

class SattvaRitualsApp extends StatelessWidget {
  const SattvaRitualsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sattva Rituals',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: HomeView(),
    );
  }
}
