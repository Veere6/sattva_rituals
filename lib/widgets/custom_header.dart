import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../controllers/cart_controller.dart';
import '../views/cart_view.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        children: [
          // Logo Section
          InkWell(
            onTap: () => Get.offAllNamed('/'),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.eco, color: AppTheme.primaryGreen, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  'SATTVA',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                    color: AppTheme.deepForest,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Navigation Links
          _navLink("SHOP"),
          _navLink("OUR STORY"),
          _navLink("AYURVEDA 101"),
          _navLink("JOURNAL"),
          const SizedBox(width: 40),
          // Icon Actions
          _headerIcon(Icons.search_rounded, () {}),
          _headerIcon(Icons.person_outline_rounded, () {}),
          Obx(() => _headerIcon(
                Icons.shopping_cart_outlined,
                () => Get.to(() => const CartView()),
                badgeCount: cartController.totalItemsCount,
              )),
        ],
      ),
    );
  }

  Widget _navLink(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        onPressed: () {},
        child: Text(
          title,
          style: GoogleFonts.montserrat(
            color: AppTheme.deepForest,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  Widget _headerIcon(IconData icon, VoidCallback onTap, {int badgeCount = 0}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Stack(
        children: [
          IconButton(
            onPressed: onTap,
            icon: Icon(icon, color: AppTheme.deepForest, size: 24),
          ),
          if (badgeCount > 0)
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: AppTheme.primaryBlue, shape: BoxShape.circle),
                constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                child: Text(
                  '$badgeCount',
                  style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
