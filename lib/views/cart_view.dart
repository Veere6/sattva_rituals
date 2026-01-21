import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/cart_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_header.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F2),
      appBar: const CustomHeader(),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_bag_outlined, size: 64, color: AppTheme.deepForest.withOpacity(0.1)),
                const SizedBox(height: 24),
                Text(
                  'YOUR CART IS EMPTY',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: AppTheme.deepForest.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 32),
                OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.deepForest),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: Text(
                    'CONTINUE SHOPPING',
                    style: GoogleFonts.montserrat(
                      color: AppTheme.deepForest,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 16 : 40),
            child: Flex(
              direction: isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cart Items Section
                Expanded(
                  flex: isMobile ? 0 : 2,
                  child: Column(
                    children: cartController.cartItems.map((product) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: EdgeInsets.all(isMobile ? 16 : 24),
                        color: Colors.white,
                        child: Row(
                          children: [
                            Image.network(
                              product.imageUrl,
                              width: isMobile ? 80 : 120,
                              height: isMobile ? 80 : 120,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name.toUpperCase(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w800,
                                      fontSize: isMobile ? 13 : 16,
                                      color: AppTheme.deepForest,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'AUTHENTIC RITUAL',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 9,
                                      color: AppTheme.primaryGreen,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      _quantityBtn(Icons.remove, () => cartController.removeFromCart(product)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Obx(() => Text(
                                          '${product.quantityInCart.value}',
                                          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 13),
                                        )),
                                      ),
                                      _quantityBtn(Icons.add, () => cartController.addToCart(product)),
                                      const Spacer(),
                                      Text(
                                        '₹${product.price}',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w800,
                                          fontSize: isMobile ? 14 : 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (!isMobile) ...[
                              const SizedBox(width: 24),
                              IconButton(
                                icon: const Icon(Icons.delete_outline, color: Colors.grey, size: 20),
                                onPressed: () => cartController.clearProductFromCart(product),
                              ),
                            ],
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(width: isMobile ? 0 : 40, height: isMobile ? 24 : 0),
                // Summary Section
                Container(
                  width: isMobile ? double.infinity : 400,
                  padding: EdgeInsets.all(isMobile ? 24 : 40),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ORDER SUMMARY',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 2,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 32),
                      _summaryRow('Subtotal', '₹${cartController.totalAmount.toStringAsFixed(2)}'),
                      const SizedBox(height: 16),
                      _summaryRow('Shipping', 'FREE'),
                      const Divider(height: 48),
                      _summaryRow('TOTAL', '₹${cartController.totalAmount.toStringAsFixed(2)}', isBold: true),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () => cartController.sendToWhatsApp(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryBlue,
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                            elevation: 0,
                          ),
                          child: Text(
                            'ORDER VIA WHATSAPP',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Text(
                          'Secure Ayurvedic Checkout',
                          style: GoogleFonts.montserrat(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _quantityBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Icon(icon, size: 12, color: AppTheme.deepForest),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.montserrat(
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
            fontSize: isBold ? 16 : 12,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w700,
            fontSize: isBold ? 20 : 14,
          ),
        ),
      ],
    );
  }
}
