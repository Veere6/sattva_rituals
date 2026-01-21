import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/product_model.dart';
import '../controllers/product_controller.dart';
import '../controllers/cart_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_header.dart';
import '../widgets/product_card.dart';

class ProductDetailView extends StatelessWidget {
  final Product product;
  final CartController cartController = Get.find<CartController>();
  final ProductController productController = Get.find<ProductController>();

  ProductDetailView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side: Large Image Gallery
                  Expanded(
                    flex: 1,
                    child: Hero(
                      tag: 'product_image_${product.id}',
                      child: Container(
                        height: 800,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 80),
                  // Right Side: Details
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AUTHENTIC RITUAL",
                          style: GoogleFonts.montserrat(
                            color: AppTheme.primaryGreen,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          product.name.toUpperCase(),
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            color: AppTheme.deepForest,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Text(
                              "₹${product.price}",
                              style: GoogleFonts.montserrat(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.deepForest,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              color: AppTheme.primaryGreen.withOpacity(0.1),
                              child: Text(
                                "IN STOCK",
                                style: GoogleFonts.montserrat(
                                  color: AppTheme.primaryGreen,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Text(
                          product.description,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey[700],
                            height: 1.8,
                          ),
                        ),
                        const Divider(height: 80),
                        _buildSectionHeader("BENEFITS"),
                        _buildChecklist(product.benefits),
                        const SizedBox(height: 40),
                        _buildSectionHeader("INGREDIENTS"),
                        _buildChecklist(product.ingredients),
                        const SizedBox(height: 40),
                        _buildSectionHeader("HOW TO USE"),
                        Text(
                          product.usage,
                          style: GoogleFonts.poppins(
                            fontStyle: FontStyle.italic,
                            color: AppTheme.deepForest,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 60),
                        Row(
                          children: [
                            _quantitySelector(),
                            const SizedBox(width: 20),
                            Expanded(
                              child: SizedBox(
                                height: 64,
                                child: ElevatedButton(
                                  onPressed: () {
                                    cartController.addToCart(product);
                                    Get.snackbar(
                                      'SUCCESS',
                                      'Added to your collection.',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: AppTheme.deepForest,
                                      colorText: Colors.white,
                                      borderRadius: 0,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryBlue,
                                    foregroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    "ADD TO CART",
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        _buildPolicyInfo(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _buildRelatedProducts(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w800,
          letterSpacing: 2,
          fontSize: 14,
          color: AppTheme.deepForest,
        ),
      ),
    );
  }

  Widget _buildChecklist(List<String> items) {
    return Column(
      children: items.map((item) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            const Icon(Icons.eco_outlined, color: AppTheme.primaryGreen, size: 18),
            const SizedBox(width: 12),
            Text(item, style: GoogleFonts.poppins(color: Colors.grey[800])),
          ],
        ),
      )).toList(),
    );
  }

  Widget _quantitySelector() {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          _qtyBtn(Icons.remove, () => cartController.removeFromCart(product)),
          Container(
            width: 60,
            alignment: Alignment.center,
            child: Obx(() => Text(
              '${product.quantityInCart.value}',
              style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
            )),
          ),
          _qtyBtn(Icons.add, () => cartController.addToCart(product)),
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 64,
        alignment: Alignment.center,
        child: Icon(icon, size: 16, color: AppTheme.deepForest),
      ),
    );
  }

  Widget _buildPolicyInfo() {
    return Column(
      children: [
        _policyRow(Icons.local_shipping_outlined, "Free shipping on orders over ₹1000"),
        const SizedBox(height: 12),
        _policyRow(Icons.history_outlined, "Easy 7-day return policy"),
      ],
    );
  }

  Widget _policyRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 12),
        Text(text, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
      ],
    );
  }

  Widget _buildRelatedProducts() {
    // Filter out current product
    final related = productController.products.where((p) => p.id != product.id).take(4).toList();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 120),
          Text(
            "COMPLETING THE RITUAL",
            style: GoogleFonts.montserrat(
              color: AppTheme.primaryGreen,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Related Products",
            style: GoogleFonts.playfairDisplay(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: AppTheme.deepForest,
            ),
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.7,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
            ),
            itemCount: related.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 500),
                columnCount: 4,
                child: ScaleAnimation(
                  child: FadeInAnimation(
                    child: ProductCard(product: related[index], index: index),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
