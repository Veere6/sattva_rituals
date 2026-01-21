import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sattva_rituals/views/ayurveda_101_view.dart';
import 'package:sattva_rituals/views/home_view.dart';
import 'package:sattva_rituals/views/journal_view.dart';
import '../theme/app_theme.dart';
import '../controllers/cart_controller.dart';
import '../views/cart_view.dart';
import '../views/our_story_view.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 768;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        border: Border(
          bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 60),
      child: Row(
        children: [
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu, color: AppTheme.deepForest),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          // Logo Section
          InkWell(
            onTap: () => Get.offAllNamed('/'),
            child: Row(
              children: [
                Container(
                  // padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset("assets/icon/Sattva.png",height: 40,width: 40,),
                  // child: const Icon(Icons.eco, color: AppTheme.primaryGreen, size: 20),
                ),
                const SizedBox(width: 8),
                Text(
                  'SATTVA',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w900,
                    letterSpacing: isMobile ? 2 : 4,
                    color: AppTheme.deepForest,
                    fontSize: isMobile ? 16 : 22,
                  ),
                ),
              ],
            ),
          ),
          if (!isMobile) const Spacer(),
          // Navigation Links (Desktop Only)
          if (!isMobile) ...[
            _navLink("SHOP", () => Get.to(() => HomeView())),
            _navLink("OUR STORY", () => Get.to(() => const OurStoryView())),
            _navLink("AYURVEDA 101", () => Get.to(() => const Ayurveda101View())),
            _navLink("JOURNAL", () => Get.to(() => const JournalView())),
          ],
          if (isMobile) const Spacer(),
          // Icon Actions
          // if (!isMobile) _headerIcon(Icons.search_rounded, () {}),
          // _headerIcon(Icons.person_outline_rounded, () {}),
          Obx(() => _headerIcon(
                Icons.shopping_cart_outlined,
                () => Get.to(() => const CartView()),
                badgeCount: cartController.totalItemsCount,
              )),
        ],
      ),
    );
  }

  Widget _navLink(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        onPressed: onTap,
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
      padding: const EdgeInsets.only(left: 4),
      child: Stack(
        children: [
          IconButton(
            onPressed: onTap,
            icon: Icon(icon, color: AppTheme.deepForest, size: 22),
          ),
          if (badgeCount > 0)
            Positioned(
              right: 4,
              top: 4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(color: AppTheme.primaryBlue, shape: BoxShape.circle),
                constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                child: Text(
                  '$badgeCount',
                  style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}