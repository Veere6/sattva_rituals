import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductController extends GetxController {
  final ApiService _apiService = ApiService();
  var products = <Product>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      errorMessage('');
      var fetchedProducts = await _apiService.fetchProducts();
      products.assignAll(fetchedProducts);
    } catch (e) {
      errorMessage('Failed to load products: $e');
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
