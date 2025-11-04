import 'package:flutter/material.dart';
import 'package:vtutemplate/components/profile_option_new_tile.dart';

class Settings extends StatelessWidget {
  const Settings({super.key, required this.primaryapptheme,required this.bgColor,});

  final Color primaryapptheme;
  final Color bgColor;
  
@override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, // ~4% screen width
            vertical: height * 0.015,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOption(
                title: 'Profile',
                asset: 'assets/images/profile.png',
                onTap: () {},
              ),
              const SizedBox(height: 10),
              _buildOption(
                title: 'Linked Accounts',
                asset: 'assets/images/linkedacct.png',
                onTap: () {},
              ),
              const SizedBox(height: 10),
              _buildOption(
                title: 'Referrals',
                asset: 'assets/images/referrals.png',
                onTap: () {},
              ),
              const SizedBox(height: 10),
              _buildOption(
                title: 'Security',
                asset: 'assets/images/security.png',
                onTap: () {},
              ),
              const SizedBox(height: 10),
              _buildOption(
                title: 'About Us',
                asset: 'assets/images/aboutus.png',
                onTap: () {},
              ),
              const SizedBox(height: 10),
              _buildOption(
                title: 'FAQs',
                asset: 'assets/images/FAQs.png',
                onTap: () {},
              ),
              const SizedBox(height: 10),
              _buildOption(
                title: 'Log Out',
                asset: 'assets/images/logout.png',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// --- Reusable option builder ---
  Widget _buildOption({
    required String title,
    required String asset,
    required VoidCallback onTap,
  }) {
    return ProfileOptionNewTile(
      title: title,
      leading: Image.asset(
        asset,
        width: 22, // Scaled up for mobile
        height: 22,
        fit: BoxFit.contain,
      ),
      onTap: onTap,
    );
  }
}