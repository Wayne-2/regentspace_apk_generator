import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Icontabs extends StatelessWidget {
  const Icontabs({
    super.key,
    required this.icon,
    required this.label,
    required this.themecolor,
    required this.color,
    required this.height,
    required this.width,
    required this.iconsize,
    required this.onTap
  });
  final IconData icon;
  final Color themecolor;
  final Color color;
  final String label;
  final double height;
  final double width;
  final double iconsize;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.black12, width: 1),
              color: themecolor,
            ),
            child: Center(
              child: Icon(icon, size: iconsize, color: color),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.poppins(
            color: Color.fromRGBO(62, 62, 62, 1),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
