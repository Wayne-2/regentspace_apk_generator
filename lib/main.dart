import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vtutemplate/components/navigator.dart';
import 'package:vtutemplate/constants.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: LoadingPage()),
  );
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Status bar color & immersive mode
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Animation for fade-in effect
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(seconds: 6), () {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNav(
            appNameColor: CanvasConfig.appNameColor,
            primaryapptheme: CanvasConfig.primaryAppTheme,
            iconthemeColor: CanvasConfig.iconThemeColor,
            selectedBgImagePath: CanvasConfig.selectedBgImagePath,
            bgColor: CanvasConfig.bgColor,
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: CanvasConfig.bgColor,
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(CanvasConfig.appLogo, width: 150, height: 150),
              const SizedBox(height: 30),

              // App Name
              Text(
                CanvasConfig.appName,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: CanvasConfig.appNameColor
                ),
              ),

              const SizedBox(height: 20),

              // Sub-text (tagline)
              const Text(
                CanvasConfig.appIntroMessage,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 40),

              // Loading Indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
