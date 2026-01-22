import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_header.dart';

class InfoView extends StatelessWidget {
  final String title;
  final String content;

  const InfoView({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomHeader(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 100,
          vertical: isMobile ? 40 : 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: GoogleFonts.montserrat(
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: GoogleFonts.playfairDisplay(
                fontSize: isMobile ? 36 : 48,
                fontWeight: FontWeight.bold,
                color: AppTheme.deepForest,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              content,
              style: GoogleFonts.poppins(
                fontSize: 16,
                height: 1.8,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.deepForest,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
              child: const Text("BACK TO HOME"),
            ),
          ],
        ),
      ),
    );
  }
}
