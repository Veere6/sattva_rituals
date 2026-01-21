import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/product_model.dart';

class CartController extends GetxController {
  final _storage = GetStorage();
  
  // List of products currently in cart
  var cartItems = <Product>[].obs;
  
  // List of favorite products
  var favoriteItems = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Load favorites and cart from storage could be implemented here
  }

  void toggleFavorite(Product product) {
    product.isFavorite.value = !product.isFavorite.value;
    if (product.isFavorite.value) {
      if (!favoriteItems.contains(product)) {
        favoriteItems.add(product);
      }
    } else {
      favoriteItems.remove(product);
    }
  }

  void addToCart(Product product) {
    product.quantityInCart.value++;
    if (!cartItems.contains(product)) {
      cartItems.add(product);
    }
  }

  void removeFromCart(Product product) {
    if (product.quantityInCart.value > 0) {
      product.quantityInCart.value--;
      if (product.quantityInCart.value == 0) {
        cartItems.remove(product);
      }
    }
  }

  void clearProductFromCart(Product product) {
    product.quantityInCart.value = 0;
    cartItems.remove(product);
  }

  double get totalAmount => cartItems.fold(
      0, (sum, item) => sum + (item.price * item.quantityInCart.value));

  int get totalItemsCount => cartItems.fold(
      0, (sum, item) => sum + item.quantityInCart.value);

  Future<void> sendToWhatsApp() async {
    if (cartItems.isEmpty) return;

    String phoneNumber = "9131087223"; // Replace with actual number
    String message = "✨ *Sattva Rituals Order* ✨\n\n";
    
    for (var item in cartItems) {
      message += "🌿 ${item.name} x ${item.quantityInCart.value} - ₹${(item.price * item.quantityInCart.value).toStringAsFixed(2)}\n";
    }

    message += "\n*Total Amount: ₹${totalAmount.toStringAsFixed(2)}*\n\nThank you!";
    
    final url = "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Error", "Could not launch WhatsApp",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
