import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_header.dart';

class JournalView extends StatelessWidget {
  const JournalView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 768;
    double horizontalPadding = isMobile ? 20 : screenWidth * 0.2;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      appBar: const CustomHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Text(
              "SATTVA JOURNAL",
              style: GoogleFonts.montserrat(letterSpacing: 8, fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              "Rituals, Recipes & Remedies",
              style: GoogleFonts.playfairDisplay(fontSize: isMobile ? 32 : 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60),

            // FEATURED POST
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: _buildFeaturedPost(isMobile),
            ),

            const SizedBox(height: 80),

            // ARTICLE LIST
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  _buildJournalRow(isMobile, "01", "The Art of Mindful Breathing", "Wellness", "Oct 12, 2023"),
                  _buildJournalRow(isMobile, "02", "Golden Milk: The Ancient Recipe", "Nutrition", "Oct 08, 2023"),
                  _buildJournalRow(isMobile, "03", "Seasonal Living: Autumn Transition", "Rituals", "Oct 05, 2023"),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedPost(bool isMobile) {
    return Column(
      children: [
        Image.network(
          'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&q=80&w=1600',
          width: double.infinity,
          height: isMobile ? 300 : 500,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("LATEST ARTICLE", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 12, color: AppTheme.primaryGreen)),
            Text("5 MIN READ", style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 15),
        Text(
          "Why Morning Sunlight is the Ultimate Ayurvedic Hack",
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(fontSize: isMobile ? 24 : 36, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Text(
          "Discover how catching the first rays of dawn can balance your Sadhaka Pitta and set your circadian rhythm for a restful night's sleep.",
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(fontSize: 16, height: 1.6, color: Colors.black54),
        ),
        TextButton(
          onPressed: () {},
          child: Text("CONTINUE READING —", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: Colors.black)),
        )
      ],
    );
  }

  Widget _buildJournalRow(bool isMobile, String number, String title, String category, String date) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        children: [
          if (!isMobile) ...[
            Text(number, style: GoogleFonts.playfairDisplay(fontSize: 14, color: Colors.grey)),
            const SizedBox(width: 40),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category.toUpperCase(), style: GoogleFonts.montserrat(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen)),
                const SizedBox(height: 8),
                Text(title, style: GoogleFonts.playfairDisplay(fontSize: isMobile ? 18 : 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Text(date, style: GoogleFonts.lato(color: Colors.grey, fontSize: 12)),
          const SizedBox(width: 20),
          const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.black),
        ],
      ),
    );
  }
}