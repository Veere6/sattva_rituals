import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product_model.dart';
import '../controllers/cart_controller.dart';
import '../theme/app_theme.dart';
import '../views/product_detail_view.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;

  const ProductCard({super.key, required this.product, required this.index});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return _HoverAnimator(
      child: GestureDetector(
        onTap: () => Get.to(() => ProductDetailView(product: product)),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        child: Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: const BoxDecoration(
                          color: AppTheme.primaryBlue,
                        ),
                        child: Text(
                          "BEST SELLER",
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Obx(() => IconButton(
                        icon: Icon(
                          product.isFavorite.value ? Icons.favorite : Icons.favorite_border,
                          color: product.isFavorite.value ? Colors.red : AppTheme.deepForest.withOpacity(0.3),
                          size: 20,
                        ),
                        onPressed: () => cartController.toggleFavorite(product),
                      )),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 12, 15, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ...List.generate(5, (i) => const Icon(Icons.star, color: Colors.amber, size: 12)),
                            const SizedBox(width: 6),
                            Text(
                              "(4.9)",
                              style: GoogleFonts.montserrat(fontSize: 10, color: Colors.grey[400], fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.name.toUpperCase(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            letterSpacing: 0.5,
                            color: AppTheme.deepForest,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "AUTHENTIC AYURVEDA",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                            fontSize: 8,
                            color: AppTheme.primaryGreen,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "₹${product.price}",
                          style: GoogleFonts.montserrat(
                            color: AppTheme.deepForest,
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryBlue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () => cartController.addToCart(product),
                    child: Text(
                      "ADD TO CART",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HoverAnimator extends StatefulWidget {
  final Widget child;
  const _HoverAnimator({required this.child});

  @override
  State<_HoverAnimator> createState() => _HoverAnimatorState();
}

class _HoverAnimatorState extends State<_HoverAnimator> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutQuint,
        transform: isHovered 
          ? (Matrix4.identity()..translate(0, -12, 0)) 
          : Matrix4.identity(),
        child: AnimatedScale(
          scale: isHovered ? 1.01 : 1.0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutQuint,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                if (isHovered)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 40,
                    offset: const Offset(0, 25),
                  ),
              ],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
