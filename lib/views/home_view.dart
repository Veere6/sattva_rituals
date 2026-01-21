import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../theme/app_theme.dart';
import '../controllers/product_controller.dart';
import '../controllers/cart_controller.dart';
import '../widgets/product_card.dart';
import '../widgets/custom_header.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final ProductController productController = Get.find<ProductController>();
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomHeader(), // Using the dedicated custom header
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            _buildCategoryRibbon(),
            _buildModernSectionHeader("Curated for You", "Our Popular Products"),
            _buildProductGrid(),
            _buildFullWidthPromo(),
            _buildModernSectionHeader("Browse by Ritual", "Shop by Category"),
            _buildModernCategorySection(),
            _buildAyurvedaPhilosophySection(),
            _buildModernSectionHeader("Trusted by Thousands", "Customer Testimonials"),
            _buildModernReviewSection(),
            _buildModernSectionHeader("Ancient Secrets", "Top Selling Rituals"),
            _buildProductGrid(),
            _buildNewsletterSection(),
            _buildModernFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 600,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=1600',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 60,
            bottom: 100,
            child: AnimationConfiguration.synchronized(
              child: FadeInAnimation(
                duration: const Duration(seconds: 1),
                child: SlideAnimation(
                  verticalOffset: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          "ESTD. 1924",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Ancient Wisdom\nFor Modern Life",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 64,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Handcrafted Ayurvedic rituals delivered from our ashram to your home.",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: AppTheme.deepForest,
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                            ),
                            child: const Text("SHOP COLLECTION", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                          ),
                          const SizedBox(width: 20),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white, width: 2),
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                            ),
                            child: const Text("OUR STORY", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRibbon() {
    final categories = ["DIGESTION", "IMMUNITY", "HAIR CARE", "SKIN RITUALS", "STRESS RELIEF"];
    return Container(
      height: 80,
      color: AppTheme.deepForest,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                categories[index],
                style: GoogleFonts.montserrat(
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModernSectionHeader(String subtitle, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 80, 24, 40),
      child: Column(
        children: [
          Text(
            subtitle.toUpperCase(),
            style: GoogleFonts.montserrat(
              color: AppTheme.primaryGreen,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.playfairDisplay(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: AppTheme.deepForest,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 60,
            height: 2,
            color: AppTheme.primaryGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 0.7,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
          ),
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 500),
              columnCount: 4,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: ProductCard(product: productController.products[index], index: index),
                ),
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildFullWidthPromo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 80),
      height: 400,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1615485290382-441e4d0c9cb5?auto=format&fit=crop&q=80&w=1600'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: AppTheme.deepForest.withOpacity(0.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CLEANSE. HEAL. NOURISH.",
              style: GoogleFonts.montserrat(color: Colors.white, letterSpacing: 4, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              "Seasonal Detox Collection",
              style: GoogleFonts.playfairDisplay(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              ),
              child: const Text("SHOP THE COLLECTION"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernCategorySection() {
    final rituals = [
      {'name': 'MORNING RITUAL', 'img': 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=400'},
      {'name': 'EVENING CALM', 'img': 'https://images.unsplash.com/photo-1512428813834-c702c7702b78?q=80&w=400'},
      {'name': 'INNER GLOW', 'img': 'https://images.unsplash.com/photo-1601049541289-9b1b7bbbfe19?q=80&w=400'},
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        children: rituals.map((ritual) {
          return Expanded(
            child: Container(
              height: 500,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(ritual['img']!), fit: BoxFit.cover),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.2),
                child: Center(
                  child: Text(
                    ritual['name']!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 24),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAyurvedaPhilosophySection() {
    return Container(
      padding: const EdgeInsets.all(100),
      color: const Color(0xFFF9F6F2),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("OUR PHILOSOPHY", style: GoogleFonts.montserrat(color: AppTheme.primaryGreen, letterSpacing: 3, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                Text(
                  "Balance is not something you find, it's something you create.",
                  style: GoogleFonts.playfairDisplay(fontSize: 48, fontWeight: FontWeight.bold, height: 1.2),
                ),
                const SizedBox(height: 30),
                Text(
                  "We believe that true beauty and health come from a harmonious connection between the mind, body, and soul. Our products are formulated using 5,000-year-old traditional techniques.",
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.grey[700], height: 1.8),
                ),
                const SizedBox(height: 40),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text("LEARN ABOUT AYURVEDA", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: AppTheme.deepForest, letterSpacing: 1)),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_forward, color: AppTheme.primaryGreen),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 100),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(width: 400, height: 500, color: AppTheme.primaryGreen.withOpacity(0.1)),
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Image.network('https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernReviewSection() {
    return Container(
      height: 400,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 60),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 400,
            margin: const EdgeInsets.only(right: 30),
            padding: const EdgeInsets.all(40),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.format_quote, color: AppTheme.primaryGreen, size: 48),
                const SizedBox(height: 20),
                Text(
                  "The Ashwagandha rituals have completely transformed my evening routine. I feel more centered and rested than ever before.",
                  style: GoogleFonts.playfairDisplay(fontSize: 20, fontStyle: FontStyle.italic, color: AppTheme.deepForest),
                ),
                const Spacer(),
                Row(
                  children: [
                    const CircleAvatar(backgroundColor: AppTheme.primaryGreen, child: Text("A", style: TextStyle(color: Colors.white))),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ANANYA SHARMA", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text("Verified Customer", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildNewsletterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      width: double.infinity,
      color: AppTheme.deepForest,
      child: Column(
        children: [
          Text("JOIN THE RITUAL", style: GoogleFonts.montserrat(color: AppTheme.primaryGreen, letterSpacing: 4, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text("Get 15% off your first order", style: GoogleFonts.playfairDisplay(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          SizedBox(
            width: 500,
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "YOUR EMAIL ADDRESS",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), letterSpacing: 2),
                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.primaryGreen)),
                suffixIcon: TextButton(
                  onPressed: () {},
                  child: const Text("SUBSCRIBE", style: TextStyle(color: AppTheme.primaryGreen, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(80, 80, 80, 40),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SATTVA', style: GoogleFonts.montserrat(fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 24)),
                    const SizedBox(height: 20),
                    Text(
                      "Crafting authentic Ayurvedic experiences for the modern world since 1924. Our mission is to bring balance to your daily life through ancient rituals.",
                      style: TextStyle(color: Colors.grey[600], height: 1.8),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        _socialIcon(Icons.facebook),
                        _socialIcon(Icons.camera_alt),
                        _socialIcon(Icons.alternate_email),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              _footerColumn("SHOP", ["Digestion", "Immunity", "Skin", "Hair", "Stress"]),
              _footerColumn("RESOURCES", ["Our Story", "The Ashram", "Ayurveda 101", "Journal"]),
              _footerColumn("SUPPORT", ["Contact Us", "Shipping", "Returns", "Wholesale"]),
            ],
          ),
          const SizedBox(height: 80),
          const Divider(),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("© 2024 SATTVA RITUALS. TRADITION IN EVERY DROP.", style: GoogleFonts.montserrat(fontSize: 10, letterSpacing: 1, fontWeight: FontWeight.w600)),
              Text("PRIVACY POLICY / TERMS OF SERVICE", style: GoogleFonts.montserrat(fontSize: 10, letterSpacing: 1, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Icon(icon, color: AppTheme.deepForest, size: 20),
    );
  }

  Widget _footerColumn(String title, List<String> items) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 2)),
          const SizedBox(height: 20),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(item, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
              )),
        ],
      ),
    );
  }
}
