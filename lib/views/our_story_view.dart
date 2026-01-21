import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_header.dart';

class OurStoryView extends StatelessWidget {
  const OurStoryView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 768;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomHeader(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 60,
            vertical: isMobile ? 40 : 80,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "OUR STORY",
                    style: GoogleFonts.montserrat(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "The Genesis of Sattva Rituals",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: isMobile ? 36 : 56,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.deepForest,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: isMobile ? 100 : 150,
                    height: 2,
                    color: AppTheme.primaryGreen.withOpacity(0.5),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Sattva Rituals was born from a desire to reconnect with the ancient wisdom of nature and the timeless traditions of holistic well-being. In a world of fleeting trends and synthetic solutions, we sought to create something pure, authentic, and deeply rooted in the principles of Ayurveda.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 16 : 18,
                      color: Colors.grey[800],
                      height: 1.8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=1600', // Placeholder
                      height: isMobile ? 300 : 500,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "Our journey began in the verdant landscapes of Kerala, where generations have harnessed the healing power of botanicals. We partnered with local artisans and Ayurvedic experts to craft rituals that not only nourish the skin and hair but also soothe the soul. Each product is a testament to our commitment to purity, sustainability, and the profound connection between human and nature.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 14 : 16,
                      color: Colors.grey[700],
                      height: 1.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}