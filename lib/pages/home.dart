import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vtutemplate/components/addmoney.dart';
import 'package:vtutemplate/components/icontabs.dart';
import 'package:vtutemplate/riverpod/riverpod.dart';
import 'package:vtutemplate/utils/buyairtime.dart';
import 'package:vtutemplate/utils/buydata.dart';
import 'package:vtutemplate/utils/cabletvsub.dart';
import 'package:vtutemplate/utils/electricalbill.dart';

class Home extends ConsumerStatefulWidget {
  const Home({
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

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {

  final List<String> images = ['assets/ads3.png', 'assets/ads4.png'];

  unavailable() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Feature is unavailable")));
  }

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileProvider);
    final displayName = userProfile?.username ?? "User";

    final screenHeight = MediaQuery.of(context).size.height;
    final size = MediaQuery.of(context).size; // Get device size
    final height = size.height;
    // final width = size.width;

    return Scaffold(
      backgroundColor: widget.bgColor,
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
                        'Hello, $displayName',
                        style: GoogleFonts.poppins(fontSize: 12),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      addMoneyDialog(context, onConfirm: (double amount, String method) {});
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.black, width: 1),
                            color: widget.primaryapptheme,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.add_circle,
                                size: 14,
                                color: widget.iconthemeColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Add Money",
                                style: TextStyle(
                                  fontSize: 11,
                                  color: widget.iconthemeColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.notifications_outlined, size: 18),
                      ],
                    ),
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
                    image: AssetImage(widget.selectedBgImagePath),
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
                          fontSize: 24,
                          color: widget.primaryapptheme,
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
                                const ClipboardData(text: "1100336447"),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Account number copied!'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.copy,
                                  size: 14,
                                  color: Colors.white,
                                ),
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
                crossAxisSpacing: 8,
                mainAxisSpacing: 4,
                childAspectRatio: 1, // make each tile more square-like
                padding: EdgeInsets.zero, // remove extra padding
                children: [
                  Icontabs(
                    icon: Icons.phone_android,
                    color: widget.iconthemeColor,
                    label: 'Airtime',
                    themecolor: widget.primaryapptheme,
                    height: 36,
                    width: 36,
                    iconsize: 18,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AirtimePage()),
                      );
                    },
                  ),
                  Icontabs(
                    icon: Icons.wifi,
                    color: widget.iconthemeColor,
                    label: 'Data',
                    themecolor: widget.primaryapptheme,
                    height: 36,
                    width: 36,
                    iconsize: 18,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              const BuyDataPage(serviceID: "mtn-data"),
                        ),
                      );
                    },
                  ),
                  Icontabs(
                    icon: Icons.bolt,
                    color: widget.iconthemeColor,
                    label: 'Electric',
                    themecolor: widget.primaryapptheme,
                    height: 36,
                    width: 36,
                    iconsize: 18,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ElectricityBillPage(),
                        ),
                      );
                    },
                  ),
                  Icontabs(
                    icon: Icons.tv,
                    color: widget.iconthemeColor,
                    label: 'Cable',
                    themecolor: widget.primaryapptheme,
                    height: 36,
                    width: 36,
                    iconsize: 18,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TvSubscriptionPage(),
                        ),
                      );
                    },
                  ),
                  Icontabs(
                    icon: Icons.sports_soccer,
                    color: widget.iconthemeColor,
                    label: 'Betting',
                    themecolor: widget.primaryapptheme,
                    height: 36,
                    width: 36,
                    iconsize: 18,
                    onTap: () {},
                  ),
                  Icontabs(
                    icon: Icons.flight,
                    color: widget.iconthemeColor,
                    label: 'Flight',
                    themecolor: widget.primaryapptheme,
                    height: 36,
                    width: 36,
                    iconsize: 18,
                    onTap: () {
                      unavailable();
                    },
                  ),
                  Icontabs(
                    icon: Icons.shopping_cart,
                    color: widget.iconthemeColor,
                    label: 'Shop',
                    themecolor: widget.primaryapptheme,
                    height: 36,
                    width: 36,
                    iconsize: 18,
                    onTap: () {
                      unavailable();
                    },
                  ),
                  Icontabs(
                    icon: Icons.generating_tokens,
                    color: widget.iconthemeColor,
                    label: 'Results',
                    themecolor: widget.primaryapptheme,
                    height: 36,
                    width: 36,
                    iconsize: 18,
                    onTap: () {
                      unavailable();
                    },
                  ),
                ],
              ),

              const SizedBox(height: 10),

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
