import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtutemplate/components/icontabs.dart';

class Home extends StatelessWidget {
  Home({
    super.key,
    required this.primaryapptheme,
    required this.bgColor,
    required this.iconthemeColor,
    required this.selectedBgImagePath,
  });

  final Color primaryapptheme;
  final Color bgColor;
  final Color iconthemeColor;
  final String selectedBgImagePath;


  final List<String> images = ['assets/ads3.png', 'assets/ads4.png'];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size; // Get device size
    final height = size.height;
    // final width = size.width;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// --- Header Row ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: Color.fromRGBO(168, 168, 168, 1),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Hello, User',
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black, width: 1),
                          color: primaryapptheme,
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.add_circle,
                                size: 14, color: iconthemeColor),
                            const SizedBox(width: 4),
                            Text(
                              "Add Money",
                              style: TextStyle(
                                fontSize: 11,
                                color: iconthemeColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.notifications_outlined, size: 18),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 15),

              /// --- Account Card ---
              Container(
                width: double.infinity,
                height: height * 0.18, // 18% of screen height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(selectedBgImagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black.withOpacity(0.4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Account Balance",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "₦ 2,554,706",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: primaryapptheme,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            "Moniepoint",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                  const ClipboardData(text: "1100336447"));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Account number copied!'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.copy,
                                    size: 14, color: Colors.white),
                                const SizedBox(width: 3),
                                Text(
                                  "1100336447",
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// --- Services Section ---
              Text(
                "Top-up Services",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),

              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
                children: [
                  Icontabs(
                    icon: Icons.phone_android,
                    color: iconthemeColor,
                    label: 'Airtime',
                    themecolor: primaryapptheme,
                    height: 40,
                    width: 40,
                    iconsize: 18,
                  ),
                  Icontabs(
                    icon: Icons.wifi,
                    color: iconthemeColor,
                    label: 'Data',
                    themecolor: primaryapptheme,
                    height: 40,
                    width: 40,
                    iconsize: 18,
                  ),
                  Icontabs(
                    icon: Icons.bolt,
                    color: iconthemeColor,
                    label: 'Electric',
                    themecolor: primaryapptheme,
                    height: 40,
                    width: 40,
                    iconsize: 18,
                  ),
                  Icontabs(
                    icon: Icons.tv,
                    color: iconthemeColor,
                    label: 'Cable',
                    themecolor: primaryapptheme,
                    height: 40,
                    width: 40,
                    iconsize: 18,
                  ),
                  Icontabs(
                    icon: Icons.sports_soccer,
                    color: iconthemeColor,
                    label: 'Betting',
                    themecolor: primaryapptheme,
                    height: 40,
                    width: 40,
                    iconsize: 18,
                  ),
                  Icontabs(
                    icon: Icons.flight,
                    color: iconthemeColor,
                    label: 'Flight',
                    themecolor: primaryapptheme,
                    height: 40,
                    width: 40,
                    iconsize: 18,
                  ),
                  Icontabs(
                    icon: Icons.shopping_cart,
                    color: iconthemeColor,
                    label: 'Shop',
                    themecolor: primaryapptheme,
                    height: 40,
                    width: 40,
                    iconsize: 18,
                  ),
                  Icontabs(
                    icon: Icons.generating_tokens,
                    color: iconthemeColor,
                    label: 'Results',
                    themecolor: primaryapptheme,
                    height: 40,
                    width: 40,
                    iconsize: 18,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// --- Ads Section ---
              Text(
                "Advertisements",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              CarouselSlider(
                options: CarouselOptions(
                  height: screenHeight * 0.2,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                ),
                items: images.map((url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(url),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

}
