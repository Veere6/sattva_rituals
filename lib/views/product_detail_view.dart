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
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 60, 
                vertical: isMobile ? 40 : 80
              ),
              child: Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side: Large Image Gallery
                  Expanded(
                    flex: isMobile ? 0 : 1,
                    child: Hero(
                      tag: 'product_image_${product.id}',
                      child: Container(
                        height: isMobile ? 400 : 800,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(product.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: isMobile ? 0 : 80, height: isMobile ? 40 : 0),
                  // Right Side: Details
                  Expanded(
                    flex: isMobile ? 0 : 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AUTHENTIC RITUAL",
                          style: GoogleFonts.montserrat(
                            color: AppTheme.primaryGreen,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                            fontSize: 10,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          product.name.toUpperCase(),
                          style: GoogleFonts.playfairDisplay(
                            fontSize: isMobile ? 32 : 48,
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
                                fontSize: isMobile ? 24 : 32,
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
                            fontSize: isMobile ? 14 : 16,
                            color: Colors.grey[700],
                            height: 1.8,
                          ),
                        ),
                        Divider(height: isMobile ? 60 : 80),
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
                            fontSize: isMobile ? 14 : 16,
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
                                      margin: const EdgeInsets.all(16),
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
            _buildRelatedProducts(context),
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
          fontSize: 12,
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
            const Icon(Icons.eco_outlined, color: AppTheme.primaryGreen, size: 16),
            const SizedBox(width: 12),
            Expanded(child: Text(item, style: GoogleFonts.poppins(color: Colors.grey[800], fontSize: 13))),
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
            width: 50,
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
        width: 44,
        height: 64,
        alignment: Alignment.center,
        child: Icon(icon, size: 14, color: AppTheme.deepForest),
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
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 12),
        Text(text, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildRelatedProducts(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 768;
    int crossAxisCount = screenWidth > 1200 ? 4 : (screenWidth > 768 ? 3 : 2);
    
    // Filter out current product
    final related = productController.products.where((p) => p.id != product.id).take(4).toList();
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(height: isMobile ? 80 : 120),
          Text(
            "COMPLETING THE RITUAL",
            style: GoogleFonts.montserrat(
              color: AppTheme.primaryGreen,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Related Products",
            style: GoogleFonts.playfairDisplay(
              fontSize: isMobile ? 28 : 40,
              fontWeight: FontWeight.w700,
              color: AppTheme.deepForest,
            ),
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.65,
              crossAxisSpacing: isMobile ? 12 : 30,
              mainAxisSpacing: isMobile ? 12 : 30,
            ),
            itemCount: related.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 500),
                columnCount: crossAxisCount,
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
