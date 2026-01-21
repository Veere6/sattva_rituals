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
      appBar: const CustomHeader(),
      drawer: _buildMobileDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildCategoryRibbon(),
            _buildModernSectionHeader("Curated for You", "Our Popular Products"),
            _buildProductGrid(context),
            _buildFullWidthPromo(context),
            _buildModernSectionHeader("Browse by Ritual", "Shop by Category"),
            _buildModernCategorySection(context),
            _buildAyurvedaPhilosophySection(context),
            _buildModernSectionHeader("Trusted by Thousands", "Customer Testimonials"),
            _buildModernReviewSection(context),
            _buildModernSectionHeader("Ancient Secrets", "Top Selling Rituals"),
            _buildProductGrid(context),
            _buildNewsletterSection(context),
            _buildModernFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppTheme.deepForest),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.eco, color: AppTheme.primaryGreen, size: 40),
                const SizedBox(height: 10),
                Text(
                  'SATTVA RITUALS',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          _drawerItem("SHOP", Icons.shopping_bag_outlined),
          _drawerItem("OUR STORY", Icons.history),
          _drawerItem("AYURVEDA 101", Icons.menu_book),
          _drawerItem("JOURNAL", Icons.article_outlined),
        ],
      ),
    );
  }

  Widget _drawerItem(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.deepForest),
      title: Text(title, style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
      onTap: () => Get.back(),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 768;

    return Container(
      height: isMobile ? 400 : 600,
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
            left: isMobile ? 24 : 60,
            bottom: isMobile ? 40 : 100,
            right: isMobile ? 24 : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    "ESTD. 1924",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Ancient Wisdom\nFor Modern Life",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: isMobile ? 36 : 64,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Handcrafted Ayurvedic rituals delivered home.",
                  style: GoogleFonts.poppins(
                    fontSize: isMobile ? 14 : 18,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(height: 30),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.deepForest,
                        padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 40, vertical: isMobile ? 16 : 20),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      ),
                      child: const Text("SHOP COLLECTION", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                    ),
                    if (!isMobile)
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white, width: 2),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        ),
                        child: const Text("OUR STORY", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1)),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryRibbon() {
    final categories = ["DIGESTION", "IMMUNITY", "HAIR CARE", "SKIN RITUALS", "STRESS RELIEF"];
    return Container(
      height: 60,
      color: AppTheme.deepForest,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                categories[index],
                style: GoogleFonts.montserrat(
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildModernSectionHeader(String subtitle, String title) {
    return Builder(builder: (context) {
      bool isMobile = MediaQuery.of(context).size.width < 768;
      return Padding(
        padding: EdgeInsets.fromLTRB(24, isMobile ? 40 : 80, 24, isMobile ? 20 : 40),
        child: Column(
          children: [
            Text(
              subtitle.toUpperCase(),
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.w700,
                letterSpacing: 3,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: isMobile ? 28 : 40,
                fontWeight: FontWeight.w700,
                color: AppTheme.deepForest,
              ),
            ),
            const SizedBox(height: 16),
            Container(width: 40, height: 2, color: AppTheme.primaryGreen),
          ],
        ),
      );
    });
  }

  Widget _buildProductGrid(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 1200 ? 4 : (screenWidth > 768 ? 3 : 2);
    double padding = screenWidth > 768 ? 60 : 16;

    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.65,
            crossAxisSpacing: screenWidth > 768 ? 30 : 12,
            mainAxisSpacing: screenWidth > 768 ? 30 : 12,
          ),
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 500),
              columnCount: crossAxisCount,
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

  Widget _buildFullWidthPromo(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      margin: EdgeInsets.symmetric(vertical: isMobile ? 40 : 80),
      height: isMobile ? 300 : 400,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1615485290382-441e4d0c9cb5?auto=format&fit=crop&q=80&w=1600'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        color: AppTheme.deepForest.withOpacity(0.7),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "CLEANSE. HEAL. NOURISH.",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(color: Colors.white, letterSpacing: 4, fontWeight: FontWeight.bold, fontSize: isMobile ? 12 : 14),
            ),
            const SizedBox(height: 16),
            Text(
              "Seasonal Detox Collection",
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(fontSize: isMobile ? 28 : 48, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: const Text("SHOP COLLECTION"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernCategorySection(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;
    final rituals = [
      {'name': 'MORNING RITUAL', 'img': 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=400'},
      {'name': 'EVENING CALM', 'img': 'https://images.unsplash.com/photo-1512428813834-c702c7702b78?q=80&w=400'},
      {'name': 'INNER GLOW', 'img': 'https://images.unsplash.com/photo-1601049541289-9b1b7bbbfe19?q=80&w=400'},
    ];

    if (isMobile) {
      return SizedBox(
        height: 400,
        child: PageView.builder(
          itemCount: rituals.length,
          itemBuilder: (context, index) {
            return _ritualItem(rituals[index], isMobile: true);
          },
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60),
      child: Row(
        children: rituals.map((ritual) => Expanded(child: _ritualItem(ritual))).toList(),
      ),
    );
  }

  Widget _ritualItem(Map<String, String> ritual, {bool isMobile = false}) {
    return Container(
      height: isMobile ? 400 : 500,
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
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
              fontSize: isMobile ? 20 : 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAyurvedaPhilosophySection(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      padding: EdgeInsets.all(isMobile ? 24 : 100),
      color: const Color(0xFFF9F6F2),
      child: Flex(
        direction: isMobile ? Axis.vertical : Axis.horizontal,
        children: [
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("OUR PHILOSOPHY", style: GoogleFonts.montserrat(color: AppTheme.primaryGreen, letterSpacing: 3, fontWeight: FontWeight.bold, fontSize: 10)),
                const SizedBox(height: 20),
                Text(
                  "Balance is something you create.",
                  style: GoogleFonts.playfairDisplay(fontSize: isMobile ? 32 : 48, fontWeight: FontWeight.bold, height: 1.2),
                ),
                const SizedBox(height: 24),
                Text(
                  "We believe that true beauty and health come from a harmonious connection between the mind, body, and soul.",
                  style: GoogleFonts.poppins(fontSize: isMobile ? 14 : 18, color: Colors.grey[700], height: 1.8),
                ),
                const SizedBox(height: 32),
                TextButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("LEARN MORE", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: AppTheme.deepForest, letterSpacing: 1, fontSize: 12)),
                      const SizedBox(width: 10),
                      const Icon(Icons.arrow_forward, color: AppTheme.primaryGreen, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!isMobile) const SizedBox(width: 100),
          if (isMobile) const SizedBox(height: 40),
          Expanded(
            flex: isMobile ? 0 : 1,
            child: Image.network(
              'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=800',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernReviewSection(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      height: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 60),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: isMobile ? 300 : 400,
            margin: const EdgeInsets.only(right: 20),
            padding: EdgeInsets.all(isMobile ? 24 : 40),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.format_quote, color: AppTheme.primaryGreen, size: 32),
                const SizedBox(height: 16),
                Text(
                  "The Ashwagandha rituals have completely transformed my evening routine. I feel more centered and rested.",
                  style: GoogleFonts.playfairDisplay(fontSize: isMobile ? 16 : 20, fontStyle: FontStyle.italic, color: AppTheme.deepForest),
                ),
                const Spacer(),
                Row(
                  children: [
                    const CircleAvatar(radius: 16, backgroundColor: AppTheme.primaryGreen, child: Text("A", style: TextStyle(color: Colors.white, fontSize: 12))),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ANANYA SHARMA", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 12)),
                        Text("Verified Customer", style: TextStyle(color: Colors.grey[600], fontSize: 10)),
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

  Widget _buildNewsletterSection(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      padding: EdgeInsets.symmetric(vertical: isMobile ? 60 : 100, horizontal: 24),
      width: double.infinity,
      color: AppTheme.deepForest,
      child: Column(
        children: [
          Text("JOIN THE RITUAL", style: GoogleFonts.montserrat(color: AppTheme.primaryGreen, letterSpacing: 4, fontWeight: FontWeight.bold, fontSize: 10)),
          const SizedBox(height: 16),
          Text(
            "Get 15% off first order",
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(fontSize: isMobile ? 28 : 40, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: isMobile ? double.infinity : 500,
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "YOUR EMAIL ADDRESS",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), letterSpacing: 2, fontSize: 12),
                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppTheme.primaryGreen)),
                suffixIcon: TextButton(
                  onPressed: () {},
                  child: const Text("JOIN", style: TextStyle(color: AppTheme.primaryGreen, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernFooter(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      padding: EdgeInsets.fromLTRB(isMobile ? 24 : 80, isMobile ? 60 : 80, isMobile ? 24 : 80, 40),
      color: Colors.white,
      child: Column(
        children: [
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('SATTVA', style: GoogleFonts.montserrat(fontWeight: FontWeight.w900, letterSpacing: 4, fontSize: 24)),
                const SizedBox(height: 20),
                Text("Authentic Ayurvedic experiences since 1924.", style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 40),
                _footerColumn("SHOP", ["Digestion", "Immunity", "Skin Care"]),
                const SizedBox(height: 32),
                _footerColumn("SUPPORT", ["Contact Us", "Shipping", "Returns"]),
              ],
            )
          else
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
                        "Crafting authentic Ayurvedic experiences for the modern world since 1924.",
                        style: TextStyle(color: Colors.grey[600], height: 1.8),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                _footerColumn("SHOP", ["Digestion", "Immunity", "Skin", "Hair"]),
                _footerColumn("RESOURCES", ["Our Story", "The Ashram", "Ayurveda 101"]),
                _footerColumn("SUPPORT", ["Contact Us", "Shipping", "Returns"]),
              ],
            ),
          const SizedBox(height: 60),
          const Divider(),
          const SizedBox(height: 40),
          Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("© 2024 SATTVA RITUALS.", style: GoogleFonts.montserrat(fontSize: 10, letterSpacing: 1, fontWeight: FontWeight.w600)),
              if (isMobile) const SizedBox(height: 12),
              Text("PRIVACY / TERMS", style: GoogleFonts.montserrat(fontSize: 10, letterSpacing: 1, fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footerColumn(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 2)),
        const SizedBox(height: 16),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(item, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
            )),
      ],
    );
  }
}
