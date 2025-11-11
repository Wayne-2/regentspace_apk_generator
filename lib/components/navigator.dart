// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:vtutemplate/pages/finances.dart';
import 'package:vtutemplate/pages/home.dart';
import 'package:vtutemplate/pages/settings.dart';


class BottomNav extends StatefulWidget {
  final Color appNameColor;
  final Color primaryapptheme;
  final Color bgColor;
  final Color iconthemeColor;
  final String? selectedBgImagePath;

  const BottomNav({
    super.key,
    required this.appNameColor,
    required this.primaryapptheme,
    required this.bgColor,
    required this.iconthemeColor,
    required this.selectedBgImagePath,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex = 0;

  late final List<Widget> pages;
  late final Home homePage;
  late final Settings settingsPage;
  late final Finances financesPage;

  @override
  void initState() {
    super.initState();
    homePage = Home(
      primaryapptheme: widget.primaryapptheme,
      iconthemeColor: widget.iconthemeColor,
      bgColor: widget.bgColor,
      selectedBgImagePath: 'assets/newbg.png',
    );
    financesPage = Finances(
      primaryapptheme: widget.primaryapptheme,
      bgColor: widget.bgColor,
      iconColor: widget.iconthemeColor,
    );
    settingsPage = Settings(
      primaryapptheme: widget.primaryapptheme,
      bgColor: widget.bgColor,
    );

    pages = [
      homePage,
      financesPage,
      settingsPage,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[currentTabIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white, // rounded corners
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(LucideIcons.home, "Home", 0),
            _buildNavItem(LucideIcons.wallet, "Finances", 1),
            _buildNavItem(LucideIcons.settings, "Settings", 2),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = currentTabIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => currentTabIndex = index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? widget.primaryapptheme.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: isSelected ? 24 : 22,
              color: isSelected ? widget.primaryapptheme : Colors.grey,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                color: isSelected ? widget.primaryapptheme : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
