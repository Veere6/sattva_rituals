import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'home_view.dart';
import 'our_story_view.dart';
import 'journal_view.dart';
import 'ayurveda_101_view.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeView(),
    const OurStoryView(),
    const JournalView(),
    const Ayurveda101View(),
  ];

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.grid_view_outlined, 'activeIcon': Icons.grid_view_rounded, 'label': 'SHOP'},
    {'icon': Icons.spa_outlined, 'activeIcon': Icons.spa_rounded, 'label': 'STORY'},
    {'icon': Icons.edit_note_outlined, 'activeIcon': Icons.edit_note_rounded, 'label': 'JOURNAL'},
    {'icon': Icons.self_improvement_outlined, 'activeIcon': Icons.self_improvement_rounded, 'label': 'WISDOM'},
  ];

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;

    return Scaffold(
      extendBody: true, // Allows content to be visible behind the floating bar
      body: _pages[_selectedIndex],
      bottomNavigationBar: isMobile ? _buildAnimatedBottomBar() : null,
    );
  }

  Widget _buildAnimatedBottomBar() {
    return Container(
      height: 75,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 25),
      decoration: BoxDecoration(
        color: AppTheme.deepForest.withOpacity(0.98),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_navItems.length, (index) {
            bool isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
                padding: EdgeInsets.symmetric(
                  horizontal: isSelected ? 20 : 12, 
                  vertical: 12
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primaryGreen.withOpacity(0.2) : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedScale(
                      scale: isSelected ? 1.1 : 1.0,
                      duration: const Duration(milliseconds: 400),
                      child: Icon(
                        isSelected ? _navItems[index]['activeIcon'] : _navItems[index]['icon'],
                        color: isSelected ? AppTheme.primaryGreen : Colors.white.withOpacity(0.5),
                        size: 24,
                      ),
                    ),
                    if (isSelected)
                      AnimatedOpacity(
                        opacity: isSelected ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 400),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            _navItems[index]['label'],
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
