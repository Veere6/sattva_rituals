import 'package:get/get.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> benefits;
  final List<String> ingredients;
  final String usage;
  final int stock;
  
  // These are stateful and used for UI logic
  var isFavorite = false.obs;
  var quantityInCart = 0.obs;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.benefits,
    required this.ingredients,
    required this.usage,
    this.stock = 10,
    bool initialIsFavorite = false,
  }) {
    isFavorite.value = initialIsFavorite;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      benefits: List<String>.from(json['benefits'] ?? []),
      ingredients: List<String>.from(json['ingredients'] ?? []),
      usage: json['usage'] ?? '',
      stock: json['stock'] ?? 10,
      initialIsFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'benefits': benefits,
      'ingredients': ingredients,
      'usage': usage,
      'stock': stock,
      'isFavorite': isFavorite.value,
    };
  }
}
