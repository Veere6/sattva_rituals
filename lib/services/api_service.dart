import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/product_model.dart';

class ApiService {
  // Path to local asset
  static const String _localPath = 'assets/data/products.json';

  Future<List<Product>> fetchProducts() async {
    try {
      // Loading from local assets as requested
      final String response = await rootBundle.loadString(_localPath);
      final List<dynamic> data = json.decode(response);
      return data.map((item) => Product.fromJson(item)).toList();
    } catch (e) {
      throw Exception('Error loading products from local storage: $e');
    }
  }
}
