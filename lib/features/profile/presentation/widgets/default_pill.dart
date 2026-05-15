import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/common/constants/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultPill extends StatelessWidget {
  final String label;

  const DefaultPill({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, size: 14, color: AppConstants.primaryColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.outfit(
              color: AppConstants.primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 11,
            ),
          ), // Text
        ], // Row
      ), // Row
    ); // Container
  }
}
