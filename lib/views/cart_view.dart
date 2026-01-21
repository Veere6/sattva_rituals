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

    return Scaffold(
      backgroundColor: const Color(0xFFF9F6F2),
      appBar: const CustomHeader(), // Consistent website header
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_bag_outlined, size: 80, color: AppTheme.deepForest.withOpacity(0.1)),
                const SizedBox(height: 24),
                Text(
                  'YOUR CART IS EMPTY',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
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
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  child: Text(
                    'CONTINUE SHOPPING',
                    style: GoogleFonts.montserrat(
                      color: AppTheme.deepForest,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Side: Cart Items
            Expanded(
              flex: 2,
              child: ListView.builder(
                padding: const EdgeInsets.all(40),
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final product = cartController.cartItems[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(24),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.zero,
                    ),
                    child: Row(
                      children: [
                        Image.network(
                          product.imageUrl,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name.toUpperCase(),
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  letterSpacing: 1,
                                  color: AppTheme.deepForest,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'AUTHENTIC RITUAL',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  color: AppTheme.primaryGreen,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  _quantityBtn(Icons.remove, () => cartController.removeFromCart(product)),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Obx(() => Text(
                                      '${product.quantityInCart.value}',
                                      style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  _quantityBtn(Icons.add, () => cartController.addToCart(product)),
                                  const Spacer(),
                                  Text(
                                    '₹${product.price}',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                      color: AppTheme.deepForest,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 40),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.grey),
                          onPressed: () => cartController.clearProductFromCart(product),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Right Side: Order Summary
            Container(
              width: 450,
              margin: const EdgeInsets.fromLTRB(0, 40, 40, 40),
              padding: const EdgeInsets.all(40),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'ORDER SUMMARY',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _summaryRow('Subtotal', '₹${cartController.totalAmount.toStringAsFixed(2)}'),
                  const SizedBox(height: 20),
                  _summaryRow('Shipping', 'FREE'),
                  const Divider(height: 60),
                  _summaryRow('TOTAL', '₹${cartController.totalAmount.toStringAsFixed(2)}', isBold: true),
                  const SizedBox(height: 40),
                  const Text(
                    'Tax included. Shipping calculated at checkout.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
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
                          letterSpacing: 2,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Secure Checkout Guaranteed',
                      style: GoogleFonts.montserrat(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _quantityBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Icon(icon, size: 16, color: AppTheme.deepForest),
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
            fontSize: isBold ? 18 : 14,
            letterSpacing: 1,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w700,
            fontSize: isBold ? 24 : 16,
          ),
        ),
      ],
    );
  }
}
