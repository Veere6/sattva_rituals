import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_header.dart';

class Ayurveda101View extends StatelessWidget {
  const Ayurveda101View({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 768;
    double horizontalPadding = isMobile ? 20 : screenWidth * 0.15;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // WEBSITE HERO SECTION
            Container(
              width: double.infinity,
              height: isMobile ? 300 : 500,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1506126613408-eca07ce68773?q=80&w=2000'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: Text(
                    'Ancient Wisdom for Modern Life',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: isMobile ? 32 : 64,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // MAIN CONTENT (Center Aligned with Max Width)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "THE FOUNDATIONS",
                          style: GoogleFonts.montserrat(letterSpacing: 4, color: AppTheme.primaryGreen, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Understanding Your Dosha",
                          style: GoogleFonts.playfairDisplay(fontSize: 36, fontWeight: FontWeight.w700, color: AppTheme.deepForest),
                        ),
                        const SizedBox(height: 20),
                        Container(height: 2, width: 60, color: AppTheme.primaryGreen),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),

                  // RESPONSIVE GRID FOR DOSHAS
                  isMobile
                      ? Column(children: _doshaList())
                      : Row(crossAxisAlignment: CrossAxisAlignment.start, children: _doshaList().map((e) => Expanded(child: e)).toList()),

                  const SizedBox(height: 80),

                  // SECONDARY CONTENT SECTION
                  _buildWebSection(
                      isMobile,
                      "The Sattva Path",
                      "Ayurveda is not just a diet or a supplement routine; it is a way of living in sync with the rhythms of nature. By understanding your unique constitution, you can make choices that support your natural state of balance.",
                      "https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?q=80&w=800"
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _doshaList() {
    return [
      _doshaCard("VATA", "Air & Ether", "Quick-thinking, thin, and creative. Needs grounding rituals and warm foods."),
      _doshaCard("PITTA", "Fire & Water", "Goal-oriented, athletic, and intense. Needs cooling environments and moderation."),
      _doshaCard("KAPHA", "Earth & Water", "Calm, loyal, and strong. Needs stimulation, movement, and light foods."),
    ];
  }

  Widget _doshaCard(String title, String element, String desc) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Text(title, style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2)),
          const SizedBox(height: 5),
          Text(element, style: GoogleFonts.lato(fontStyle: FontStyle.italic, color: Colors.grey)),
          const SizedBox(height: 15),
          Text(desc, textAlign: TextAlign.center, style: GoogleFonts.lato(height: 1.6, fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildWebSection(bool isMobile, String title, String body, String imgUrl) {
    Widget textPart = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        Text(body, style: GoogleFonts.lato(fontSize: 18, height: 1.8, color: Colors.black87)),
      ],
    );

    Widget imagePart = ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Image.network(imgUrl, fit: BoxFit.cover),
    );

    return isMobile
        ? Column(children: [imagePart, const SizedBox(height: 30), textPart])
        : Row(children: [Expanded(child: textPart), const SizedBox(width: 60), Expanded(child: imagePart)]);
  }
}